//SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract FavoriteBooks{

    string[] public books;

    function addBook(string memory _name) public {
       books.push(_name);
    }

    function removeLastBook() public{
        books.pop();
    }

    function totalBooks() public view returns (uint){
       return  books.length;
    }
     
}


