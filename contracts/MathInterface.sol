// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

interface IMath{

    function add(uint a, uint b)external pure returns(uint);

    function sub(uint a, uint b)external pure returns(uint);

    function mul(uint a, uint b)external pure returns(uint);

    function div(uint a, uint b)external pure returns(uint);
}

contract Math is IMath{

    function add(uint a, uint b)external pure returns(uint){
        return a + b;
    }

    function sub(uint a, uint b)external pure returns(uint){
        return a - b;
    }

    function mul(uint a, uint b)external pure returns(uint){
        return a * b;
    }

    function div(uint a, uint b)external pure returns(uint){
        require(b > 0, "Division by zero");
        return a / b;
    }
}