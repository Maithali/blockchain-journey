// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract WhileLoopDemo {
    uint public counter;
    
    function countToFive()public{
        while(counter < 5){
            counter ++;
        }
    }
}