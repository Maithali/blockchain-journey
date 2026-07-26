//SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;


contract ConstructorDemo{
    string public ownerName;
    
    constructor(){
        ownerName = "Maithali";
    }
}