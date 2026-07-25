// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract DigitalWallet {

    // State Variable
    address public owner;

    // Set the owner address
    function setOwner(address _owner) public {
        owner = _owner;
    }

    // Get the owner address
    function getOwner() public view returns (address) {
        return owner;
    }

    // Deposit Ether into the contract
    function deposit() public payable {
        // Ether is automatically stored in the contract
    }
}