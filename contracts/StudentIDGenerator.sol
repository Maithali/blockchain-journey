// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract StudentIDGenerator {
    uint[] public studentIDs;

    function generateIDs(uint totalStudents) public{
        for (uint i = 1; i <= totalStudents; i++) 
        {
            studentIDs.push(i);
        }
    }

    function totalstudent() public  view returns (uint){
        return  studentIDs.length;
    }
}