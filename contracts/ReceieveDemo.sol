// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract ReceiveDemo {
    uint public receivedAmount;
    
    receive() external payable {
        receivedAmount += msg.value;
    }
}