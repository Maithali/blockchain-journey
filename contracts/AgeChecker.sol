//SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract AgeChecker{

    function CheckEligibiilty(uint _age) public pure returns(string memory){

        if(_age >= 18){
           return "You are eligible to vote";
        }
        else{
            return "You are not eligible to vote";
        }
        }
}