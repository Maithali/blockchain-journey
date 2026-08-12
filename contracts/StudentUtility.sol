// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

library StudentLibrary {
    function isEligible(uint age) internal pure returns(bool){
        return age >= 18;
    }
}

contract StudentSystem {
    function checkEligibility(uint age) public pure returns(string memory){
        require(StudentLibrary.isEligible(age),"NOT Eligible");
        return "Eligible";
    }
}