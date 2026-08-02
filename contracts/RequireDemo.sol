//SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;


contract RequireDemo {

    function checkAge(uint age) public pure returns(string memory) {
        require (age >= 18, "Age must be at least 18");
        return "You are eligible";

    }
}