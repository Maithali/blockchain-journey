// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract PersonalWallet {
    mapping(address => uint) public balances;

    event Deposit(address indexed user, uint amount);

    function deposit() public payable {
        require(msg.value >= 0.005 ether, "At least 0.005 ETH");

        balances[msg.sender] += msg.value;

        emit Deposit(msg.sender, msg.value);
    }

    function getMyBalance() public view returns (uint) {
        return balances[msg.sender];
    }

    function contractBalance() public view returns (uint) {
        return address(this).balance;
    }
}