//SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract MutabilityDemo{
    uint public number = 100;

    function getNumber() public view returns(uint){
        return number;
    }

    function add(uint a, uint b) public pure returns(uint){
        return a + b;
    }

    function deposit() public payable{
       
    }
}