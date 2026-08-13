// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract DonationReceiver{
    uint public totalDonation;

    event DonationReceived( address indexed donor, uint amount);

     receive() external payable{
        totalDonation += msg.value;

        emit DonationReceived(msg.sender, msg.value);

     }
}