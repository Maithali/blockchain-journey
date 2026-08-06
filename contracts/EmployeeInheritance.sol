// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Employee {
    string public company = "OpenAi";

    function comanyName() public pure returns (string memory) {
        return "OpenAi";
    }
}

contract Manager is Employee{
    
}