//SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract VisibilityDemo{
    uint public publicNumber = 10;
    uint private privateNumber = 20;
    uint internal internalNumber = 30;
    

    function getPrivateNumber() public view returns(uint){
        return privateNumber;
    }

    function getInternalNumber() public view returns(uint){
        return internalNumber;
    }
}