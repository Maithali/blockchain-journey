// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract UserBalance{
    mapping(address => uint) public balances;

    function deposit() public payable {
        balances[msg.sender] += msg.value;
    }

    function getMyBalance() public view returns(uint){
        return balances[msg.sender];
    }

    function getContractBalance() public view returns(uint){
        return address(this).balance;
    }
}