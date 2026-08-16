// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract AccessControl {
    address public owner;
    constructor(){
        owner = msg.sender;
    }
    modifier onlyOwner(){
        require(msg.sender == owner, "Not the owner");
        _;
    }
    function changeOwner(address newOwner) public onlyOwner{
        require(newOwner != address(0),"Invalid address");
        owner = newOwner;
    }
}