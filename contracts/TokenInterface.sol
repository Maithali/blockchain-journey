// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract SimpleToken{

    mapping(address => uint) public balances;

    constructor(){
        balances[msg.sender] = 1000;

    }

    function balanceOf(address user) external view returns(uint){
        return balances[user];
    }
}

interface ISimpleToken{
    function balanceOf(address user) external view returns(uint);
}

contract TokenChecker{
    function checkBalance(address tokenAddress, address user) external view returns(uint){
        ISimpleToken token = ISimpleToken(tokenAddress);
        return token.balanceOf(user);
    }
}