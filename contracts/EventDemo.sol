//SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract EventDemo {
    event MessageSent(string message);

    function sendMessage() public {
        emit MessageSent("Hello Blockchain");
    }
}