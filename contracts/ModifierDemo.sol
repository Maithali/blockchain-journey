//SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract ModifierDemo {

    uint public age;

    modifier validAge(uint _age){
        require(_age >= 18, "Age must be at least 18");
        _;
    }

    function setAge(uint _age) public validAge(_age) {
        age = _age;
    }

}