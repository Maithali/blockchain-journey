// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

interface ICalculator {

    function add(uint a, uint b) external pure returns(uint);

}

contract Calculator is ICalculator {
    
    function add(uint a, uint b) external pure returns(uint) {
        return a+b;
    }
}