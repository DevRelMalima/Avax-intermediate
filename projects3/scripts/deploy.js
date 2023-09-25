// imports
const hre = require("hardhat");
const fs = require('fs');

// function to deploy the contracts
async function main() {

  //deploy the token
  const Malima = await hre.ethers.getContractFactory("MalimaTokenMint");
  const malima = await Malima.deploy();
  await malima.deployed();
  console.log("malima deployed to:", malima.address);


  // export the addresses
  fs.writeFileSync('scripts/address.js', `
    export const malimaAddress = '${malima.address}'

  `);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
