// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract PiggyBank {
    // Owner of the piggy bank
    address public immutable owner;

    // Events to track activity
    event Deposit(address indexed sender, uint256 amount);
    event Withdraw(uint256 amount);

    // Modifier to restrict functions only to the owner
    modifier onlyOwner() {
        require(msg.sender == owner, "Not the owner");
        _;
    }

    // Set the creator of the contract as the owner
    constructor() {
        owner = msg.sender;
    }

    /**
     * @dev Allows users to deposit ETH into the piggy bank.
     */
    receive() external payable {
        emit Deposit(msg.sender, msg.value);
    }

    /**
     * @dev Explicit deposit function (alternative to just sending ETH).
     */
    function deposit() external payable {
        emit Deposit(msg.sender, msg.value);
    }

    /**
     * @dev Checks the current balance of the piggy bank.
     * @return The balance in Wei.
     */
    function checkBalance() external view returns (uint256) {
        return address(this).balance;
    }

    /**
     * @dev Withdraws the full balance to the owner and resets the balance to 0.
     */
    function withdraw() external onlyOwner {
        uint256 balance = address(this).balance;
        require(balance > 0, "Piggy bank is empty");

        // Transfer the entire balance to the owner
        (bool success, ) = owner.call{value: balance}("");
        require(success, "Transfer failed");

        emit Withdraw(balance);
    }
}