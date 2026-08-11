// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

abstract contract PaymentProcessor {

    event PaymentProcessed(address indexed user, uint amount);

    function processPayment(uint amount)
        public
        virtual
        returns (string memory);

    function systemName() public pure returns (string memory) {
        return "Blockchain Payment System";
    }
}

contract CryptoPayment is PaymentProcessor {

    function processPayment(uint amount)
        public
        override
        returns (string memory)
    {
        require(amount > 0, "Amount must be greater than 0");

        emit PaymentProcessed(msg.sender, amount);

        return "payment processed";
    }
}