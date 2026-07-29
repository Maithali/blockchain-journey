//SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract ForLoopDemo {

    uint[] public numbers;

    function addNumbers() public{
        for(uint i = 1; i <= 5; i++){
            numbers.push(i);

        }
    }

    function getLength() public view returns(uint){
        return numbers.length;
    
    }
}