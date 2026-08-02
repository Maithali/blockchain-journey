//SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract RevertDemo {
    function checkMarks(uint marks) public pure returns(string memory) {
        if (marks < 35) {
            revert("Student Failed");
        }
        return "Student Passed";
    }
}