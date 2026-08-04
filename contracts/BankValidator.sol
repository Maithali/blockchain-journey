//SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract BankValidator {
    uint public Balance = 1000;

    function withdraw(uint amount) public {
        require( amount > 0, "Amount must be greater than zero");
        require( amount <= Balance, "Insufficient balance");
        Balance -= amount;
    }
}