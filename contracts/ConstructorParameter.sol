//SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract ConstructorParameter{
    string public studentName;
    uint public studentAge;
    
    constructor(string memory _studentName, uint _studentAge){
        studentName = _studentName;
        studentAge = _studentAge;
    }
}