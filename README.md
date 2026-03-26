# HedgeX — Predict & Hedge on Base

> The first prediction market on Base with a built-in hedging engine.
> Bet YES/NO on crypto outcomes. Hedge your positions. Trade gasless or on-chain.

[![Live App](https://img.shields.io/badge/Live%20App-hedgex--protocol.vercel.app-4D8EFF?style=flat-square)](https://hedgex-protocol.vercel.app)
[![Base Mainnet](https://img.shields.io/badge/Base-Mainnet-0052FF?style=flat-square)](https://basescan.org/address/0x3DC3e5C90Ee0DF7D3A2f1783C5fb0D14FfB544fd)
[![License: MIT](https://img.shields.io/badge/License-MIT-00D97E?style=flat-square)](LICENSE)
[![Open Source](https://img.shields.io/badge/Open%20Source-Yes-00D97E?style=flat-square)](https://github.com/azusa-lens/hedgex-protocol)

---

## What is HedgeX?

HedgeX combines **prediction markets** and **portfolio hedging** into one platform — built exclusively on Base L2.

Most prediction markets are pure gambling. HedgeX is different: every prediction position can serve as a financial hedge against your existing crypto exposure.

**Example:**
- You are LONG ETH at $2,176
- HedgeX suggests: bet NO on *"Will ETH be above $2,500 this week?"*
- If ETH drops and your trade loses → your NO bet wins, reducing your net loss

---

## Features

| Feature | Status |
|---|---|
| Binary prediction markets (YES/NO) | ✅ Live on Base Mainnet |
| Live ETH/BTC price markets (5m → Monthly) | ✅ Live |
| Hedge engine with P&L simulator | ✅ Live |
| Live hedge chart (futures + hedge line) | ✅ Live |
| Wallet connect (MetaMask) | ✅ Live |
| Custodial mode (gasless trading) | ✅ Live |
| Non-custodial mode (self-custody) | ✅ Live |
| Points system + leaderboard | ✅ Live |
| $HEDGE airdrop for early users | 🔜 Coming |
| Chainlink oracle auto-resolution | 🔜 Phase 2 |
| Perpetual futures integration | 🔜 Phase 2 |

---

## Live Contracts

| Network | Contract | Address |
|---|---|---|
| Base Mainnet | PredictionMarket | [`0x3DC3e5C90Ee0DF7D3A2f1783C5fb0D14FfB544fd`](https://basescan.org/address/0x3DC3e5C90Ee0DF7D3A2f1783C5fb0D14FfB544fd) |
| Base Sepolia | PredictionMarket | [`0x26c467f66D8172eAfeb7C9C2d7A5f271Ab1ec889`](https://sepolia.basescan.org/address/0x26c467f66D8172eAfeb7C9C2d7A5f271Ab1ec889) |

---

## Trading Modes

### ⚡ Custodial — Gasless
Deposit ETH once to HedgeX. Place unlimited bets with zero gas fees per trade. Withdraw back to your wallet anytime.

### 🔗 Non-Custodial — Self-Custody
Connect your wallet and trade directly on-chain. Each bet is a MetaMask transaction. Full self-custody, no deposits needed.

---

## $HEDGE Token & Airdrop

**100,000,000 $HEDGE** total supply. **40% allocated to community airdrop.**

Earn points now → receive $HEDGE at launch.

| Action | Points |
|---|---|
| First bet | +500 pts |
| Each bet placed | +100 pts |
| Use hedge engine | +200 pts |
| Daily login | +25 pts |
| 7-day streak | +200 pts |
| 30-day streak | +1,000 pts |
| Refer a friend | +500 pts |
| Win a prediction | +150 pts |

**Levels:** Rookie → Trader → Pro → Whale → Legend

---

## Tech Stack

| Layer | Technology |
|---|---|
| Blockchain | Base L2 (Ethereum, OP Stack) |
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
│   ├── index.html             ← Main app (markets, simulator, portfolio, points)
│   └── airdrop.html           ← $HEDGE claim page
├── docs/
│   └── HedgeX_Whitepaper_v1.docx
├── hardhat.config.js
├── .env.example
└── README.md
```

---

## Local Development

### Prerequisites
- Node.js v18+
- MetaMask wallet
- Base Sepolia ETH (free from faucet)

### Setup

```bash
# Clone
git clone https://github.com/azusa-lens/hedgex-protocol.git
cd hedgex-protocol

# Install
npm install --legacy-peer-deps

# Configure
cp .env.example .env
# Add your PRIVATE_KEY to .env

# Compile contracts
npx hardhat compile

# Deploy to testnet
npx hardhat run scripts/deploy.js --network base_sepolia

# Open frontend
open frontend/index.html
```

### Get Testnet ETH
→ [Base Sepolia Faucet](https://docs.base.org/base-chain/tools/network-faucets)

### Deploy to Mainnet
```bash
npx hardhat run scripts/deploy.js --network base
```

---

## Roadmap

### Phase 1 — Live ✅
- Prediction markets on Base mainnet
- Hedge simulator with live chart
- Custodial + non-custodial trading
- Points system + leaderboard
- Wallet connect

### Phase 2 — Q2 2025
- $HEDGE token launch
- Airdrop claim page
- Chainlink oracle auto-resolution
- Community market creation

### Phase 3 — Q3 2025
- Perpetual futures integration
- Cross-position auto-hedging
- DAO governance
- Mobile app

---

## Contributing

HedgeX is fully open source under MIT license. Contributions welcome.

1. Fork the repo
2. Create a branch: `git checkout -b feature/your-feature`
3. Commit: `git commit -m "Add your feature"`
4. Push: `git push origin feature/your-feature`
5. Open a Pull Request

---

## Grants & Funding

This project is applying for:
- [Base Grants](https://paragraph.com/@grants.base.eth)
- [Gitcoin Grants](https://gitcoin.co)
- [Optimism RetroPGF](https://retrofunding.optimism.io)

---

## Links

| | |
|---|---|
| 🌐 App | [hedgex-protocol.vercel.app](https://hedgex-protocol.vercel.app) |
| 🐦 Twitter | [@hedgexprotocol](https://twitter.com/hedgexprotocol) |
| 💬 Telegram | [t.me/hedgexprotocol](https://t.me/hedgexprotocol) |
| 📄 Whitepaper | [HedgeX_Whitepaper_v1.docx](docs/HedgeX_Whitepaper_v1.docx) |
| 🔍 Contract | [BaseScan](https://basescan.org/address/0x3DC3e5C90Ee0DF7D3A2f1783C5fb0D14FfB544fd) |

---

## License

MIT — free to use, fork, and deploy.

Built with ❤️ on Base.
