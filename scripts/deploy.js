import hre from "hardhat";

async function main() {
  const DocumentStorage = await hre.ethers.getContractFactory("DocumentStorage");
  const contract = await DocumentStorage.deploy();

  await contract.waitForDeployment();

  console.log("DocumentStorage deployed to:", await contract.getAddress());
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});