# HedgeX — Predict & Hedge on Base

> The first prediction market with a built-in hedging engine — live on Base, Arbitrum, and Optimism.
> Bet YES/NO on crypto outcomes. Hedge your positions. Trade gasless or on-chain.

[![Live App](https://img.shields.io/badge/Live%20App-hedgex--protocol.vercel.app-4D8EFF?style=flat-square)](https://hedgex-protocol.vercel.app)
[![Base Mainnet](https://img.shields.io/badge/Base-Mainnet-0052FF?style=flat-square)](https://basescan.org/address/0x3DC3e5C90Ee0DF7D3A2f1783C5fb0D14FfB544fd)
[![Arbitrum](https://img.shields.io/badge/Arbitrum-Mainnet-28A0F0?style=flat-square)](https://arbiscan.io)
[![Optimism](https://img.shields.io/badge/Optimism-Mainnet-FF0420?style=flat-square)](https://optimistic.etherscan.io)
[![License: MIT](https://img.shields.io/badge/License-MIT-00D97E?style=flat-square)](LICENSE)

---

## What is HedgeX?

HedgeX combines **prediction markets** and **portfolio hedging** into one platform — deployed across Base, Arbitrum, and Optimism.

Most prediction markets are pure gambling. HedgeX is different: every prediction position can serve as a financial hedge against your existing crypto exposure.

**Example:**
- You are LONG ETH at $2,176
- HedgeX suggests: bet NO on *"Will ETH be above $2,500 this week?"*
- If ETH drops and your trade loses → your NO bet wins, reducing your net loss

---

## Features

| Feature | Status |
|---|---|
| Binary prediction markets (YES/NO) | ✅ Live |
| Live ETH/BTC price markets (5m → Monthly) | ✅ Live |
| Hedge engine with P&L simulator | ✅ Live |
| Live hedge chart (futures + hedge line) | ✅ Live |
| Wallet connect (MetaMask) | ✅ Live |
| Custodial mode — gasless trading | ✅ Live |
| Non-custodial mode — self-custody | ✅ Live |
| Points system + leaderboard | ✅ Live |
| Multi-chain (Base, Arbitrum, Optimism) | ✅ Live |
| $HEDGE token launch | 🔜 Coming soon |
| $HEDGE airdrop for early users | 🔜 Coming soon |
| Chainlink oracle auto-resolution | 🔜 Phase 2 |
| Perpetual futures integration | 🔜 Phase 2 |

---

## Live Deployments

HedgeX is deployed on three EVM networks. Contracts are verified and live.

| Network | Status |
|---|---|
| Base Mainnet | ✅ Live |
| Arbitrum Mainnet | ✅ Live |
| Optimism Mainnet | ✅ Live |
| Base Sepolia Testnet | ✅ Live — earn points here |

---

## Trading Modes

### ⚡ Custodial — Gasless
Deposit ETH once to HedgeX. Place unlimited bets with zero gas fees per trade. Withdraw back to your wallet anytime. Best for active traders and testnet point farming.

### 🔗 Non-Custodial — Self-Custody
Connect your wallet and trade directly on-chain. Each bet is a MetaMask transaction you sign. Full self-custody, no deposits needed.

---

## $HEDGE Token

> **$HEDGE token launch is coming soon — could go live at any time.**

The $HEDGE token is the governance and utility token of HedgeX. It is currently in final preparation.

**Total supply: 100,000,000 $HEDGE — fixed forever. No inflation.**

| Allocation | % | Purpose |
|---|---|---|
| Community airdrop | 40% | Early users who earned points |
| Liquidity pool | 20% | Uniswap V3 on Base |
| Team & contributors | 15% | 1-year cliff, 2-year vest |
| Ecosystem grants | 15% | Community proposals |
| Reserve | 10% | DAO treasury |

### Earn $HEDGE now — points farm is live

| Action | Points |
|---|---|
| First bet | +500 pts |
| Each bet placed | +100 pts |
| Per 0.01 ETH wagered | +50 pts |
| Use hedge engine | +200 pts |
| Daily login | +25 pts |
| 7-day streak | +200 pts |
| 30-day streak | +1,000 pts |
| Refer a friend | +500 pts |
| Win a prediction | +150 pts |

**Levels:** Rookie → Trader → Pro → Whale → Legend

Points snapshot taken before token launch. Top users receive the largest $HEDGE allocation.

---

## Grants

HedgeX has applied for grants from:

- [Base Grants](https://paragraph.com/@grants.base.eth)
- [Gitcoin Grants](https://gitcoin.co)
- [Optimism RetroPGF](https://retrofunding.optimism.io)
- [Arbitrum Grants](https://arbitrum.foundation/grants)

> If grants are received, 100% of funds will be directed toward protocol development — including smart contract security audits, Chainlink oracle integration, frontend improvements, and community growth. No funds will be used for personal purposes.

---

## Tech Stack

| Layer | Technology |
|---|---|
| Blockchain | Base, Arbitrum, Optimism (EVM) |
| Smart contracts | Solidity 0.8.20 + OpenZeppelin |
| Dev tooling | Hardhat v2 |
| Frontend | Vanilla HTML/CSS/JS |
| Price feeds | CoinGecko API |
| Market data | Polymarket API |
| Hosting | Vercel |

---

## Project Structure

```
hedgex-protocol/
├── contracts/
│   ├── PredictionMarket.sol   ← Core prediction market contract
│   └── HedgeToken.sol         ← $HEDGE ERC-20 + airdrop distributor
├── scripts/
│   └── deploy.js              ← Deploy + seed markets
├── frontend/
│   ├── index.html             ← Main app
│   └── airdrop.html           ← $HEDGE claim page
├── docs/
│   └── HedgeX_Whitepaper_v1.docx
├── hardhat.config.js
├── .env.example
└── README.md
```

---

## Local Development

```bash
# Clone
git clone https://github.com/azusa-lens/hedgex-protocol.git
cd hedgex-protocol

# Install
npm install --legacy-peer-deps

# Configure
cp .env.example .env
# Add your PRIVATE_KEY to .env

# Compile
npx hardhat compile

# Deploy to testnet
npx hardhat run scripts/deploy.js --network base_sepolia

# Deploy to mainnet
npx hardhat run scripts/deploy.js --network base
```

**Get free testnet ETH:** [Base Sepolia Faucet](https://docs.base.org/base-chain/tools/network-faucets)

---

## Roadmap

### Phase 1 — Complete ✅
- Prediction markets on Base, Arbitrum, Optimism
- Hedge simulator with live interactive chart
- Custodial + non-custodial trading modes
- Points system + leaderboard + referrals
- Wallet connect + gasless trading
- Whitepaper published

### Phase 2 — Coming Soon 🔜
- $HEDGE token launch
- Community airdrop to point holders
- Chainlink oracle for auto-resolution
- Community market creation

### Phase 3 — If Grants Received 🎯
- Smart contract security audit
- Perpetual futures integration
- Cross-chain auto-hedging
- DAO governance launch

---

## Contributing

HedgeX is fully open source under MIT license. All contributions welcome.

1. Fork the repo
2. Create a branch: `git checkout -b feature/your-feature`
3. Commit your changes
4. Push and open a Pull Request

---

## Links

| | |
|---|---|
| 🌐 App | [hedgex-protocol.vercel.app](https://hedgex-protocol.vercel.app) |
| 🐦 Twitter | [@hedgexprotocol](https://twitter.com/hedgexprotocol) |
| 💬 Telegram | [t.me/hedgexprotocol](https://t.me/hedgexprotocol) |
| 📄 Whitepaper | [HedgeX_Whitepaper_v1.docx](docs/HedgeX_Whitepaper_v1.docx) |
| 🔍 Base Contract | [BaseScan](https://basescan.org/address/0x3DC3e5C90Ee0DF7D3A2f1783C5fb0D14FfB544fd) |

---

## License

MIT — free to use, fork, and deploy.

Built with ❤️ on Base, Arbitrum, and Optimism.
