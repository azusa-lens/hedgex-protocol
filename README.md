# HedgeX — Prediction Market + Hedge Engine on Base

> Binary prediction markets where you can hedge your futures positions.
> Built on Base L2. Open source. Free to use.

---

## What this is

A prediction market platform with a built-in hedge simulator.
Users can:
- Bet YES/NO on crypto price outcomes
- See how their prediction bet hedges a futures position
- Simulate P&L across price scenarios before betting

---

## Project structure

```
hedgex/
├── contracts/
│   └── PredictionMarket.sol     ← Deploy this to Base
├── scripts/
│   └── deploy.js                ← Creates contract + seeds 3 markets
├── frontend/
│   └── index.html               ← Full UI (no framework needed)
├── hardhat.config.js
└── package.json
```

---

## Deploy in 4 steps

### 1. Install dependencies
```bash
npm init -y
npm install --save-dev hardhat @nomicfoundation/hardhat-toolbox
npm install @openzeppelin/contracts dotenv
```

### 2. Set up environment
Create `.env`:
```
PRIVATE_KEY=your_wallet_private_key_here
BASESCAN_API_KEY=optional_for_verification
```

### 3. Get free testnet ETH
→ https://docs.base.org/base-chain/tools/network-faucets
→ Use "Base Sepolia Faucet" — free ETH for testing

### 4. Deploy
```bash
npx hardhat run scripts/deploy.js --network base_sepolia
```

This will:
- Deploy the PredictionMarket contract
- Create 3 starter markets (ETH $4k, BTC $100k, ETH $2.5k)
- Print your contract address

---

## Connect frontend to contract

After deployment, add to `frontend/index.html`:
```js
const CONTRACT_ADDRESS = "0x...your deployed address...";
const CHAIN_ID = 84532; // Base Sepolia
```

For wallet integration, add wagmi + RainbowKit:
```bash
npm create wagmi@latest
```

---

## Go to mainnet

```bash
npx hardhat run scripts/deploy.js --network base
```

Make sure you have real ETH on Base mainnet first.
Bridge from Ethereum: https://bridge.base.org

---

## Get funded

Apply for Base grants after deploying:
→ https://paragraph.com/@grants.base.eth

This project qualifies as:
- Open source DeFi infrastructure
- Novel hedging primitive on Base
- Prediction market with real utility

---

## Tech stack

| Layer | Tech |
|---|---|
| Blockchain | Base L2 (Ethereum) |
| Smart contracts | Solidity 0.8.20 + OpenZeppelin |
| Dev tooling | Hardhat |
| Frontend | Vanilla HTML/JS (zero framework) |
| Wallet (next step) | wagmi + RainbowKit |
| Oracle (next step) | Chainlink price feeds |

---

## Roadmap

- [x] Binary prediction market contract
- [x] Hedge simulator UI
- [x] Live odds + pool display
- [ ] Wallet connect (wagmi)
- [ ] Real on-chain tx submission
- [ ] Chainlink oracle resolution
- [ ] Perp futures integration (Phase 2)
- [ ] Auto-hedge bot (Phase 2)

---

## License

MIT — free to use, fork, deploy.
