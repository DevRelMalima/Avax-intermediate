const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("AvaxTokenMint", function () {
  let Token, token, owner, addr1;

  beforeEach(async function () {
    // Get the ContractFactory and Signers here.
    Token = await ethers.getContractFactory("AvaxTokenMint");
    [owner, addr1] = await ethers.getSigners();

    // Deploy the contract
    token = await Token.deploy();
  });

  describe("Deployment", function () {
    it("Should set the correct name, symbol, and owner", async function () {
      // Check the initial values after deployment
      expect(await token.tokenName()).to.equal(
        "Avax Token"
      );
      expect(await token.tokenSymbol()).to.equal("AVT");
      expect(await token.owner()).to.equal(owner.address);
    });
  });

  describe("Minting", function () {
    it("Should revert if minted by a non-owner", async function () {
      // Try to mint tokens by a non-owner
      await expect(token.connect(addr1).mint(addr1.address, 100)).to.be.revertedWith(
        "Only owner can perform this action!"
      );

      // Check that the balance and total supply remain unchanged
      expect(await token.balance(addr1.address)).to.equal(0);
      expect(await token.totalSupply()).to.equal(0);
    });
  });

  describe("Transferring", function () {
    it("Should transfer tokens between accounts", async function () {
      // Mint tokens
      await token.connect(owner).mint(owner.address, 100);

      // Transfer tokens from owner to addr1
      await token.transfer(addr1.address, 50);

      // Check the balances of addr1 and owner after the transfer
      expect(await token.balance(addr1.address)).to.equal(50);
      expect(await token.balance(owner.address)).to.equal(50);
    });

    it("Should fail if sender does not have enough tokens", async function () {
      // Mint tokens
      await token.connect(owner).mint(addr1.address, 100);

      // Try to transfer more tokens than the sender has
      await expect(token.transfer(addr1.address, 101)).to.be.revertedWith(
        "Transfer amount exceeds balance"
      );
    });

    it("Should fail if sender tries to transfer tokens to themselves", async function () {
      // Mint tokens
      await token.connect(owner).mint(owner.address, 100);

      // Try to transfer tokens to the owner address (self-transfer)
      await expect(token.transfer(owner.address, 50)).to.be.revertedWith(
        "You can not transfer token(s) to yourself!"
      );
    });
  });

  describe("Burning", function () {
    it("Should burn tokens and reduce total supply", async function () {
      // Mint tokens
      await token.connect(owner).mint(owner.address, 100);

      // Burn tokens
      await token.burn(50);

      // Check the balance and total supply after burning
      expect(await token.balance(owner.address)).to.equal(50);
      expect(await token.totalSupply()).to.equal(50);
    });

    it("Should revert if the contract creator doesn't have sufficient balance to burn", async function () {
        // Mint tokens
        await token.connect(owner).mint(owner.address, 100);
  
        // Burn tokens
        await expect(token.connect(owner).burn(101)).to.be.revertedWith("Insufficient balance");
      });
  });
});
