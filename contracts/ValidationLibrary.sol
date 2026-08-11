// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

library ValidationLibrary {
    function isAdult(uint age) internal pure returns(bool){
        return age >= 18;
    }

    function isPositve(uint amount) internal pure returns(bool){
        return amount > 0;
    }
}

contract  UserValidation {
    function checkAge(uint age) public pure returns(bool){
        return ValidationLibrary.isAdult(age);
    }

    function checkAmount(uint amount) public pure returns(bool){
        return ValidationLibrary.isPositve(amount);
    }
}