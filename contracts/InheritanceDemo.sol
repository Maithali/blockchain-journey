//SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Parent {
    string public message = "Welcome to Blockchain!";

    function greet() public pure returns (string memory) {
        return "Hello Blockchain!";
    }
}

contract child is Parent {
    
}