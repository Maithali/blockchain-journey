// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract StudentRegistry {

    mapping(uint => string) public  students;

    function addStudent(uint id, string memory name) external {
        students[id] = name;
    }

    function getStudent(uint id) external view returns(string memory) {
        return students[id];
    }

}