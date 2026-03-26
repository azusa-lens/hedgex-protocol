// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/ReentrancyGuard.sol";
import "@openzeppelin/contracts/utils/Pausable.sol";

/**
 * @title PredictionMarket
 * @notice Binary YES/NO prediction markets on Base L2.
 *         Designed to pair with futures positions as a hedge.
 * @dev Deploy on Base Sepolia first: https://sepolia.base.org
 */
contract PredictionMarket is Ownable, ReentrancyGuard, Pausable {

    uint256 public constant PLATFORM_FEE_BPS = 200;  // 2%
    uint256 public constant MIN_BET = 0.001 ether;
    uint256 public constant BPS = 10000;

    uint256 public marketCount;

    enum Outcome { UNRESOLVED, YES, NO, CANCELLED }

    struct Market {
        uint256 id;
        string  question;
        string  asset;        // "ETH", "BTC" — used for hedge pairing
        uint256 targetPrice;  // e.g. 4000e8 for $4000
        uint256 closeTime;
        uint256 resolveTime;
        uint256 yesPool;
        uint256 noPool;
        Outcome outcome;
        address creator;
        bool    feesWithdrawn;
    }

    mapping(uint256 => Market)  public markets;
    // marketId => user => isYes => amount
    mapping(uint256 => mapping(address => mapping(bool => uint256))) public positions;
    // keccak(marketId, user) => claimed
    mapping(bytes32 => bool) public claimed;

    event MarketCreated(
        uint256 indexed id,
        string  question,
        string  asset,
        uint256 targetPrice,
        uint256 closeTime
    );
    event BetPlaced(
        uint256 indexed marketId,
        address indexed user,
        bool    isYes,
        uint256 amount
    );
    event MarketResolved(uint256 indexed marketId, Outcome outcome);
    event WinningsClaimed(uint256 indexed marketId, address indexed user, uint256 amount);

    constructor() Ownable(msg.sender) {}

    // ─── Create ──────────────────────────────────────────────────────────────

    function createMarket(
        string calldata _question,
        string calldata _asset,
        uint256         _targetPrice,
        uint256         _closeTime,
        uint256         _resolveTime
    ) external returns (uint256 id) {
        require(_closeTime   > block.timestamp,  "Close must be future");
        require(_resolveTime > _closeTime,        "Resolve after close");
        require(bytes(_question).length > 0,      "Empty question");

        id = marketCount++;
        markets[id] = Market({
            id:            id,
            question:      _question,
            asset:         _asset,
            targetPrice:   _targetPrice,
            closeTime:     _closeTime,
            resolveTime:   _resolveTime,
            yesPool:       0,
            noPool:        0,
            outcome:       Outcome.UNRESOLVED,
            creator:       msg.sender,
            feesWithdrawn: false
        });

        emit MarketCreated(id, _question, _asset, _targetPrice, _closeTime);
    }

    // ─── Bet ─────────────────────────────────────────────────────────────────

    function bet(uint256 _marketId, bool _isYes)
        external payable nonReentrant whenNotPaused
    {
        Market storage m = markets[_marketId];
        require(m.closeTime   > 0,                    "Market not found");
        require(block.timestamp < m.closeTime,         "Betting closed");
        require(m.outcome == Outcome.UNRESOLVED,       "Already resolved");
        require(msg.value >= MIN_BET,                  "Below min bet");

        positions[_marketId][msg.sender][_isYes] += msg.value;
        if (_isYes) { m.yesPool += msg.value; }
        else        { m.noPool  += msg.value; }

        emit BetPlaced(_marketId, msg.sender, _isYes, msg.value);
    }

    // ─── Resolve (owner / oracle bot) ────────────────────────────────────────

    function resolve(uint256 _marketId, Outcome _outcome) external onlyOwner {
        Market storage m = markets[_marketId];
        require(m.outcome == Outcome.UNRESOLVED,  "Already resolved");
        require(block.timestamp >= m.resolveTime, "Too early");
        require(_outcome != Outcome.UNRESOLVED,   "Must set outcome");

        m.outcome = _outcome;
        emit MarketResolved(_marketId, _outcome);
    }

    // ─── Claim ───────────────────────────────────────────────────────────────

    function claim(uint256 _marketId) external nonReentrant {
        Market storage m = markets[_marketId];
        require(m.outcome != Outcome.UNRESOLVED, "Not resolved");

        bytes32 key = keccak256(abi.encodePacked(_marketId, msg.sender));
        require(!claimed[key], "Already claimed");
        claimed[key] = true;

        uint256 payout;

        if (m.outcome == Outcome.CANCELLED) {
            payout = positions[_marketId][msg.sender][true]
                   + positions[_marketId][msg.sender][false];
        } else {
            bool    wonSide   = (m.outcome == Outcome.YES);
            uint256 userStake = positions[_marketId][msg.sender][wonSide];
            require(userStake > 0, "No winning position");

            uint256 winPool   = wonSide ? m.yesPool : m.noPool;
            uint256 losePool  = wonSide ? m.noPool  : m.yesPool;
            uint256 fee       = (losePool * PLATFORM_FEE_BPS) / BPS;
            uint256 dist      = winPool + losePool - fee;

            payout = (userStake * dist) / winPool;
        }

        require(payout > 0, "Nothing to claim");
        (bool ok,) = msg.sender.call{value: payout}("");
        require(ok, "Transfer failed");

        emit WinningsClaimed(_marketId, msg.sender, payout);
    }

    // ─── Views ───────────────────────────────────────────────────────────────

    function getOdds(uint256 _marketId)
        external view returns (uint256 yesPct, uint256 noPct)
    {
        Market storage m = markets[_marketId];
        uint256 total = m.yesPool + m.noPool;
        if (total == 0) return (50, 50);
        yesPct = (m.yesPool * 100) / total;
        noPct  = 100 - yesPct;
    }

    function getMarket(uint256 _marketId)
        external view returns (Market memory)
    {
        return markets[_marketId];
    }

    function getUserPositions(uint256 _marketId, address _user)
        external view returns (uint256 yesAmt, uint256 noAmt)
    {
        yesAmt = positions[_marketId][_user][true];
        noAmt  = positions[_marketId][_user][false];
    }

    /**
     * @notice Returns potential payout for a hypothetical bet — used by hedge simulator
     */
    function simulatePayout(uint256 _marketId, bool _isYes, uint256 _betAmount)
        external view returns (uint256 estimatedPayout)
    {
        Market storage m = markets[_marketId];
        uint256 newWinPool  = (_isYes ? m.yesPool : m.noPool)  + _betAmount;
        uint256 losePool    = (_isYes ? m.noPool  : m.yesPool);
        uint256 totalPool   = newWinPool + losePool;
        uint256 fee         = (losePool * PLATFORM_FEE_BPS) / BPS;
        uint256 dist        = totalPool - fee;

        estimatedPayout = (_betAmount * dist) / newWinPool;
    }

    // ─── Admin ───────────────────────────────────────────────────────────────

    function withdrawFees(uint256 _marketId) external onlyOwner {
        Market storage m = markets[_marketId];
        require(m.outcome != Outcome.UNRESOLVED && m.outcome != Outcome.CANCELLED);
        require(!m.feesWithdrawn);
        m.feesWithdrawn = true;

        bool    wonSide  = (m.outcome == Outcome.YES);
        uint256 losePool = wonSide ? m.noPool : m.yesPool;
        uint256 fee      = (losePool * PLATFORM_FEE_BPS) / BPS;

        (bool ok,) = owner().call{value: fee}("");
        require(ok);
    }

    function pause()   external onlyOwner { _pause(); }
    function unpause() external onlyOwner { _unpause(); }
}
