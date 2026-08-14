// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract SendDemo {
    receive() external payable {}

    function withdraw (uint amount) public {
        require(address(this).balance >= amount, "Insufficient balance");
        bool success = payable(msg.sender).send(amount);
        require(success,"ether transfer failed");
    }
} 