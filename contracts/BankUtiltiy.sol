// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

library BankLibrary {
    function isValidDeposit(uint amount) internal pure returns(bool){
        return amount > 0;
    }

    function hasEnougBalance(uint balance, uint amount) internal pure returns(bool){
        return amount <= balance;
    }
}

contract Bank{
    uint public balance;

    function deposit(uint amount) public {
        require(BankLibrary.isValidDeposit(amount),"Invalid deposit");
        balance += amount;
    }

    function withdraw(uint amount) public {
        require( BankLibrary.hasEnougBalance(balance, amount),"Insuffient Balance");
        balance -= amount;
    }
}