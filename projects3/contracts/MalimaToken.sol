// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract MyToken {
    // Token information
    string public name = "MalimaToken";  // Token name
    string public symbol = "MLT";  // Token symbol
    uint8 public decimals = 18;  // Number of decimal places in token value
    uint256 public totalSupply;  // Total token supply

    // Mapping to track balances of each address
    mapping(address => uint256) public balanceOf;

    // Event emitted when tokens are transferred
    event Transfer(address indexed from, address indexed to, uint256 value);

    // Constructor to initialize the contract with an initial supply
    constructor(uint256 initialSupply) {
        totalSupply = initialSupply * 10 ** uint256(decimals);  // Set total supply
        balanceOf[msg.sender] = totalSupply;  // Assign total supply to the contract creator
    }

    // Function to transfer tokens from sender to a specified address
    function transfer(address to, uint256 value) public returns (bool) {
        require(to != address(0), "Invalid address");  // Ensure the address is valid
        require(balanceOf[msg.sender] >= value, "Insufficient balance");  // Check sender's balance

        // Update balances
        balanceOf[msg.sender] -= value;
        balanceOf[to] += value;

        // Emit a transfer event
        emit Transfer(msg.sender, to, value);
        return true;
    }

    // Function to burn (destroy) tokens
    function burn(uint256 value) public {
        require(balanceOf[msg.sender] >= value, "Insufficient balance");  // Check sender's balance

        // Update balances and total supply
        balanceOf[msg.sender] -= value;
        totalSupply -= value;

        // Emit a transfer event to address(0) (burned tokens)
        emit Transfer(msg.sender, address(0), value);
    }

    // Function to mint (create) new tokens and assign them to a specified address
    function mint(address to, uint256 value) public {
        require(to != address(0), "Invalid address");  // Ensure the address is valid

        // Update balances and total supply
        balanceOf[to] += value;
        totalSupply += value;

        // Emit a transfer event from address(0) (minted tokens)
        emit Transfer(address(0), to, value);
    }
}
