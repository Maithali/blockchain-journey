// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract EnumDemo {

    enum Status{
        Pending,
        Approved,
        Rejected
    }

    Status public currentStatus;

    function approve() public {
         currentStatus = Status.Approved;
    }

    function reject() public {
        currentStatus = Status.Rejected;
    }

    function reset() public {
        currentStatus = Status.Pending;
    }

}