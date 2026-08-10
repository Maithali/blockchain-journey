// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;


abstract contract Calculator {
    function calculate(uint a, uint b) public virtual returns(uint);

    function description() public pure returns(string memory){
        return "Basic Calcualtor";
    }
}


contract AdditionCalculator is Calculator{
    function calculate(uint a, uint b) public pure override returns(uint){
        return a+ b;
    }
}