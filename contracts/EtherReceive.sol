// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract EtherReceiver {
    uint public totalReceived;

    event EtherReceived( address indexed sender, uint amount);

    receive() external payable {
        totalReceived += msg.value;

        emit EtherReceived(msg.sender, msg.value);

    }

    fallback() external payable {
        totalReceived += msg.value;

        emit EtherReceived(msg.sender, msg.value);
    }
} 