const hre = require("hardhat");

async function main() {
  const MetaProofHub = await hre.ethers.getContractFactory("MetaProofHub");
  const metaProofHub = await MetaProofHub.deploy();

  await metaProofHub.waitForDeployment();
  console.log("✅ MetaProofHub deployed to:", await metaProofHub.getAddress());
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error("❌ Deployment error:", error);
    process.exit(1);
  });
