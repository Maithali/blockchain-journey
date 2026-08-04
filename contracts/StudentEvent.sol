// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract StudentEvent {

    string public studentName;
    uint public studentAge;

    event StudentRegistered(
        string name,
        uint age
    );

    function registerStudent(string memory _name, uint _age) public {
        studentName = _name;
        studentAge = _age;

        emit StudentRegistered(_name, _age);
    }
}