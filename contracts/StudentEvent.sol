//SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract StudentEvent{

    event  StudentRegistered(
        string name,
        uint age
    );

    function registerStudent(string memory _name, uint _age) public {
        emit  StudentRegistered(_name, _age);
    }
}