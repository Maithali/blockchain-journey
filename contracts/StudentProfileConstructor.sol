// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract StudentProfileConstructor {
    string public name;
    uint public age;
    address public owner;

    constructor(string memory _name, uint _age) {
        name = _name;
        age = _age;
        owner = msg.sender;
    }
}