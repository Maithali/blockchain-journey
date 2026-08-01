//SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract DataLocations{

    string public  name = "Maithali";

    // STORAGEDEMO
    function updateName(string memory _name) public{
        name = _name;
    }



    // MEMORYDEMO
    function getMessage() public pure returns(string memory){
        string memory message = "Welocme toBlockchain";
        return message;
    }

    // CallDataDemo
    function getName(string calldata _name) external pure returns(string memory){
        return _name;
    }

}