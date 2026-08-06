// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract University{
    string public universityName = "ABC University";

    function getUniversity() public pure returns (string memory) {
        return "ABC University";
    }
}

contract Student is University{
    
}