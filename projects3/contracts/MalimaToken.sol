// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

contract MalimaTokenMint {

    // Declare public variables
    string public tokenName;
    string public tokenSymbol;
    uint256 public totalSupply;
    address public owner;

    // Create a mapping of addresses to balances
    mapping(address => uint256) public balance;

    // Constructor function that sets the token name, symbol, and owner
    constructor() {
        tokenName = "Eth Malima Token projects 3";
        tokenSymbol = "MLT";
        owner = msg.sender;
    }

    // Modifier that only allows the owner to execute a function
    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can perform this action!");
        _;
    }

    // This function allows only the owner of the contract to mint new tokens
    function mint(address _recipient, uint256 _amount) public onlyOwner {
        // Increase the total supply
        totalSupply += _amount;
        // Increase the balance of the specified address
        balance[_recipient] += _amount;
    }

    // This function allows anyone to burn their own tokens
    // It takes one argument: the amount of tokens to burn
    function burn(uint256 _amount) public {
        // Make sure the sender has enough tokens to burn
        require(balance[msg.sender] >= _amount, "Insufficient balance");
        // Subtract the burn amount from the total supply
        totalSupply -= _amount;
        // Subtract the burn amount from the sender's balance
        balance[msg.sender] -= _amount;
    }

    // Function that allows anyone to transfer tokens to another address
    // This function transfers tokens from the sender to the recipient
    // It takes two arguments: the recipient's address and the amount of tokens to transfer
    function transfer(address _recipient, uint256 _amount) public {
        // Make sure the sender is not the recipient
        require(msg.sender != _recipient,"You can not transfer token(s) to yourself!");
        // Make sure the sender has enough tokens to transfer
        require(balance[msg.sender] >= _amount, "Transfer amount exceeds balance");
        // Subtract the transfer amount from the sender's balance
        balance[msg.sender] -= _amount;
        // Add the transfer amount to the recipient's balance
        balance[_recipient] += _amount;
    }
}
