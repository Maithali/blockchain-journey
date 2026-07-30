// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract StudentMapping {
    
    mapping(uint => string) public students;

    function addStudent(uint _rollNo, string memory _name) public {
        students[_rollNo]=_name;
    }

}