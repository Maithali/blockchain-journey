// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract FallbackDemo {
    uint public fallbackCalled;

    fallback() external {
        fallbackCalled++;
    }
}