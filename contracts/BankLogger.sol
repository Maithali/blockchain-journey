//SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract BankLogger{
    uint public balance;

    event Deposited(
        address indexed user,
        uint amount
    );

    event Withdrawn(
        address indexed user,
        uint amount
    );

    function deposit(uint amount) public {
        balance += amount;
        emit Deposited(msg.sender, amount);
    }

    function withdraw(uint amount) public {
        require(amount <= balance, "Insufficient balance");
        balance -= amount;
        emit Withdrawn(msg.sender, amount);
    }
}