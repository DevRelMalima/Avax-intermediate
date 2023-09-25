// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

contract MalimaToken {

    // Public variables that store the details about the token
    string public name;
    string public symbol;
    uint256 public totalSupply;

    // Mapping of addresses to balances
    mapping(address => uint256) public balances;

    // Constructor that initializes the token's name, symbol, and total supply
    // and sets the balance of the contract creator to the total supply
    constructor() {
        name = "Eth MalimaToken";
        symbol = "MLT";
        totalSupply = 6;
        balances[msg.sender] = 6;
    }

    // Function to mint new tokens and increase the balance of a specified address
    function mint(address _to, uint256 _value) public {
        // Make sure the address is valid
        require(_to != address(0), "Invalid address");
        // Increase the total supply
        totalSupply += _value;
        // Increase the balance of the specified address
        balances[_to] += _value;
    }

    // Function to burn tokens and decrease the balance of the contract creator
    function burn(uint256 _value) public {
        // Make sure the contract creator has sufficient balance
        require(balances[msg.sender] >= _value, "Insufficient balance");
        // Decrease the total supply
        totalSupply -= _value;
        // Decrease the balance of the contract creator
        balances[msg.sender] -= _value;
    }
}
