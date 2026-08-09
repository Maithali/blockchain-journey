// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract MyToken{
    mapping(address => uint) public balances;

    constructor(){
        balances[msg.sender] = 1000;
    }

    function balanceOf(address user) external view returns(uint){
        return balances[user];
    }
}

interface IMyToken{
    function balanceOf(address user) external view returns(uint);
}

contract BalanceChecker {
    function getBalance(address tokenAddress,address user) external view returns(uint){
        IMyToken token = IMyToken(tokenAddress);
        return token.balanceOf(user);
    }
}