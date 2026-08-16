//DO NOT DEPLOY WITH REAL FUNDS

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract VulnerableBank{

    mapping(address => uint) public balances;

    function deposit() public payable{
        balances[msg.sender] += msg.value;
    }

    function withdraw(uint amount) public {
        require( balances[msg.sender] >=amount, "Insufficient balance");

        // External call BEFORE state update
        (bool success,)= payable(msg.sender).call{value: amount}("");

        require(success, "Transfer failed");

        // State update happens too late
        balances[msg.sender] -= amount;
    }
}