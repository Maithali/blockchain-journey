// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract SecureBank {
    mapping(address => uint ) public balances;
    function deposit() public payable{
        require(msg.value > 0, "Deposit must be greater than zero");

        balances[msg.sender] += msg.value;
    }

    function withdraw(uint amount) public  {
        //CHECK
        require(balances[msg.sender] >= amount,"Insufficient balances");

        //EFFECT
        balances[msg.sender] -= amount;

        // INTERACTION
        (bool success, ) = payable(msg.sender).call{value:amount}("");

        require(success,"Transfer failed");
    }
}