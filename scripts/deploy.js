import hre from "hardhat";

async function main() {
  const [deployer] = await hre.ethers.getSigners();
  console.log("Deploying with:", deployer.address);

  const Market = await hre.ethers.getContractFactory("PredictionMarket");
  const market = await Market.deploy();
  await market.waitForDeployment();

  const addr = await market.getAddress();
  console.log("✅ PredictionMarket deployed to:", addr);
  console.log("🔗 Explorer:", `https://sepolia.basescan.org/address/${addr}`);
}

main().catch((e) => { console.error(e); process.exit(1); });