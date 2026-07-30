// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract LibraryRegistry {
    

    mapping (uint => string) public members;

    function addMember(uint id, string memory name) public {
        members[id]=name;
    }

    function getMember(uint id) public view returns (string memory) {
    return members[id];
}
}