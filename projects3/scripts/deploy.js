// imports
const hre = require("hardhat");
const fs = require('fs');

// function to deploy the contracts
async function main() {

  //deploy the token
  const Avax = await hre.ethers.getContractFactory("AvaxTokenMint");
  const avax = await Avax.deploy();
  await avax.deployed();
  console.log("avax deployed to:", avax.address);


  // export the addresses
  fs.writeFileSync('scripts/address.js', `
    export const avaxAddress = '${avax.address}'

  `);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
