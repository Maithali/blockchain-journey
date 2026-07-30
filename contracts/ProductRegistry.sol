// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract ProductRegistry {
    
    mapping(uint => string) public products;

    function addProducts(uint id, string memory name) public {
        products[id]=name;
    }

    function getProducts(uint id) public view returns(string memory){
        return products[id];
    }

   
}