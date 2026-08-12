// SPDX-License-Identifier:  MIT
pragma solidity ^0.8.20;

contract ReceiveEvent{
    event EtherReceived(address indexed sender, uint amount);

    receive() external payable {
        emit EtherReceived(msg.sender, msg.value);
    }
}