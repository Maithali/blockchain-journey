//SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract BankModifier {

    uint public balance;

    modifier validAmount(uint amount){
        require(amount > 0, "Amount must be greater than zero");
        _;
    }

    function deposit(uint amount) public validAmount(amount) {
        balance += amount;
    }

    function withdraw(uint amount) public validAmount(amount) {
        require(amount <= balance, "Insufficient balance");
        balance -= amount;
    }

}