// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

library MathLibrary {
    function add(uint a, uint b) internal pure returns(uint){
        return a + b;
    }

    function substract(uint a, uint b) internal pure returns(uint){
        return a - b;
    }

    function multiply(uint a, uint b) internal pure returns(uint){
        return a * b;
    }

    function divide(uint a, uint b) internal pure returns(uint){
        return a / b;
    }

}

contract Calculator {
    function addNumbers(uint a, uint b) public pure returns(uint){
        return MathLibrary.add(a,b);
    }

    function multiplyNumbers(uint a, uint b) public pure returns(uint){
        return MathLibrary.multiply(a, b);
    }
}