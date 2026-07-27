//SPDX-License-Identifier:MIT
pragma solidity ^0.8.20;

contract Calculator{
    
    function add(uint a, uint b) public pure returns(uint){
        return a+b;
    }

    function subtract(uint a, uint b) public pure  returns(uint){
        return a-b;
    }

    function multiply(uint a, uint b) public pure returns(uint){
        return a*b;
    }
    function divide(uint a, uint b) public pure returns(uint){
        require(b!=0,"dividsion by zero is not allowed");
        return a/b;

    }

    function remainder(uint a, uint b) public pure returns(uint){
        require(b!=0,"division by zero is not allowed");
        return a%b;
    }
  

}