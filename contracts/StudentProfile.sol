//SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract StudentProfile{
    string public studentName = "Unknown";

    function updateStudentName(string memory _name) public{
        studentName = _name;
    }

    function previewName(string calldata _name) external pure returns(string memory){
        return _name;
    }

}