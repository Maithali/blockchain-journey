// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract BalanceMapping {
    
   mapping(address => uint) public balances;

   function setbalance(uint _amount) public {
    balances[msg.sender]=_amount;
   }

   function getMyBalance() public  view  returns (uint) {
    return balances[msg.sender];
   }

}