// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/cryptography/MerkleProof.sol";

contract HedgeToken is ERC20, Ownable {

    uint256 public constant TOTAL_SUPPLY    = 100_000_000e18;
    uint256 public constant AIRDROP_ALLOC   = 40_000_000e18;
    uint256 public constant LIQUIDITY_ALLOC = 20_000_000e18;
    uint256 public constant TEAM_ALLOC      = 15_000_000e18;
    uint256 public constant ECOSYSTEM_ALLOC = 15_000_000e18;
    uint256 public constant RESERVE_ALLOC   = 10_000_000e18;

    constructor(
        address airdropContract,
        address liquidityMultisig,
        address teamTimelock,
        address ecosystemMultisig,
        address reserveMultisig
    ) ERC20("HedgeX", "HEDGE") Ownable(msg.sender) {
        _mint(airdropContract,     AIRDROP_ALLOC);
        _mint(liquidityMultisig,   LIQUIDITY_ALLOC);
        _mint(teamTimelock,        TEAM_ALLOC);
        _mint(ecosystemMultisig,   ECOSYSTEM_ALLOC);
        _mint(reserveMultisig,     RESERVE_ALLOC);
    }
}

contract HedgeAirdrop is Ownable {

    address  public immutable token;
    bytes32  public merkleRoot;
    uint256  public claimDeadline;
    mapping(address => bool) public hasClaimed;

    event Claimed(address indexed user, uint256 amount);

    constructor(address _token) Ownable(msg.sender) {
        token = _token;
    }

    function setMerkleRoot(bytes32 _root, uint256 _deadline) external onlyOwner {
        require(_deadline > block.timestamp, "Deadline must be future");
        merkleRoot = _root;
        claimDeadline = _deadline;
    }

    function claim(uint256 amount, bytes32[] calldata proof) external {
        require(block.timestamp <= claimDeadline, "Claim period ended");
        require(!hasClaimed[msg.sender], "Already claimed");
        require(merkleRoot != bytes32(0), "Root not set");

        bytes32 leaf = keccak256(abi.encodePacked(msg.sender, amount));
        require(MerkleProof.verify(proof, merkleRoot, leaf), "Invalid proof");

        hasClaimed[msg.sender] = true;
        require(IERC20(token).transfer(msg.sender, amount), "Transfer failed");
        emit Claimed(msg.sender, amount);
    }

    function sweep(address to) external onlyOwner {
        require(block.timestamp > claimDeadline, "Claim still active");
        uint256 bal = IERC20(token).balanceOf(address(this));
        require(IERC20(token).transfer(to, bal), "Transfer failed");
    }
}
