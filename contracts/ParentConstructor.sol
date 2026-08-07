// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Parent {
    string public university;

    constructor(string memory _university) {
        university   = _university;
    }
}

contract Student is Parent("ABC University") {

}