import { ethers } from "hardhat";

async function main() {

  const accounts = await ethers.getSigners();

  const wasteManagement = await ethers.deployContract("DummyToken", [100000000, 50]);
  await wasteManagement.waitForDeployment();

  const addressWasteManagement = await wasteManagement.getAddress();
  console.log("Contract Deployed at: ",addressWasteManagement);
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});