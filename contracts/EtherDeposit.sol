// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract EtherDeposit {
    uint public totalDeposited;

    function deposit() public payable{
        totalDeposited += msg.value;
    }


    function getContractBalance() public view returns(uint){
        return address(this).balance;
    }
}