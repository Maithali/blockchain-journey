// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;
contract HelloBlockchain {
    string public message = "Hello Blockchain!!!";

    //Function to update the stored message
    function updateMessage(string memory newMessage) public {
        message = newMessage;
    }

    // Function to explicitly read the stored message
    function readMessage() public view returns (string memory) {
        return message;
    }
}