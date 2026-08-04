//SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract AssertDemo{
    uint public totalStudents = 10;

    function checkStudents() public view {
        assert(totalStudents >= 10);
    }
}