//SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract VotingSystem {

    uint public voterAge;

    modifier eligibleToVote(uint _age){
        require(_age >= 18, "Age must be 18 or above");
        _;
    }

    function registerVoter(uint _age) public eligibleToVote(_age) {
        voterAge = _age;
    }

}
