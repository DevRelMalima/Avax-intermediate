const hre = require("hardhat");
const fs = require('fs');

async function main() {

  // Get the Points smart contract
  const Degen = await hre.ethers.getContractFactory("DegenToken");

  // Deploy it
  const degen = await Degen.deploy();
  await degen.deployed();

  // Display the contract address
  console.log(`Degen token deployed to ${degen.address}`);

  // export the address
  fs.writeFileSync('scripts/address.js', `
    export const tokenAddress = '${degen.address}'
  `);

  // Run verification on the contract deployment
  // npx hardhat verify your-contract-address --network fuji
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});