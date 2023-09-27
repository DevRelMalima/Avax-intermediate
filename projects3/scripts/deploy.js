const { ethers } = require('hardhat');

async function main() {
    const MalimaToken = await ethers.getContractFactory('MalimaToken');
    const malimaToken = await MalimaToken.deploy(1000000); // Initial supply: 1,000,000 tokens

    await malimaToken.deployed();

    console.log('MalimaToken deployed to:', malimaToken.address);
}

main().then(() => process.exit(0)).catch(error => {
    console.error(error);
    process.exit(1);
});
