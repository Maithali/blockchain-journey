//SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract StudentRegistration {

    string public studentName;
    uint public studentAge;

    modifier validAge(uint _age){
        require(_age >=18, "Age must be 18 or above");
        _;
    }

    function registerStudent(string memory _name, uint _age) public validAge(_age) {
        studentName = _name;
        studentAge = _age;
    }
}