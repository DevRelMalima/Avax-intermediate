// Importing ethers from the Hardhat library
const { ethers } = require('hardhat');

// Define an asynchronous function named main()
async function main() {
    // Retrieve the factory to deploy the MalimaToken contract
    const MalimaToken = await ethers.getContractFactory('MalimaToken');

    // Deploy the MalimaToken contract with an initial supply of 1,000,000 tokens
    const malimaToken = await MalimaToken.deploy(1000000);

    // Ensure the contract is deployed
    await malimaToken.deployed();

    // Log the address where the MalimaToken contract is deployed
    console.log('MalimaToken deployed to:', malimaToken.address);
}

// Call the main function and handle any errors
main().then(() => process.exit(0)).catch(error => {
    console.error(error);
    process.exit(1);
});
