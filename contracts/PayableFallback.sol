// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract PayableFallback {
    uint public received;

    fallback() external payable {
        received += msg.value;
    }
}