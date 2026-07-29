// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract EvenNumber {
    uint[] public evenNumbers;

    function generateEvenNumbers(uint limit) public {
        for(uint i = 1; i <= limit; i++){
             if(i % 2 == 0){
        evenNumbers.push(i);
    }
}

    }

    function getEvenNumbers() public view  returns (uint[] memory){
        return evenNumbers;
    }
}