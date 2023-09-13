// SPDX-License-Identifier: MIT

pragma solidity ^0.8.9;

contract ErrorHandling {
    uint public balance = 0;

    // Function to deposit an amount with a require statement
    function depositRequire(uint _amount) public {
        // Check if the deposit amount is greater than zero
        require(_amount > 0, "Deposit amount must be greater than zero");

        // Update the balance
        balance += _amount;
    }

    // Function to withdraw an amount with require statements
    function withdrawRequire(uint _amount) public {
        // Check if the withdrawal amount is greater than zero
        require(_amount > 0, "Withdrawal amount must be greater than zero");

        // Check if the withdrawal amount is not greater than the balance
        require(_amount <= balance, "Insufficient balance");

        // Update the balance
        balance -= _amount;
    }

    // Function to divide two numbers with a require statement
    function divideRequire(uint _numerator, uint _denominator) public pure returns (uint) {
        // Check if the denominator is not zero
        require(_denominator != 0, "Cannot divide by zero");

        // Perform the division and return the result
        return _numerator / _denominator;
    }

    // Function to demonstrate the use of assert statements
    function assertFunction() public pure {
        // Divide 10 by 0, which should trigger a division by zero error and revert the transaction
        uint result = divideRequire(10, 2);
        // Assert that the result is equal to 5, which will always fail and cause the transaction to fail
        assert(result == 6);
    }

    // Function to demonstrate the use of revert statements
    function revertFunction() public pure {
        // Divide 10 by 2, which will give a result of 5
        uint result = divideRequire(10, 2);
        // Check if the result is equal to 5, and if true, revert the transaction
        if(result == 5){
            revert("This function always reverts");
        }
    }
}