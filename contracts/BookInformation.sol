//SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract BookInformation{
    struct Book{
        string title;
        string author;
        uint price;
        bool available;

    }

    Book public book;

    function setBook(string memory _title, string memory _author, uint _price, bool _available) public{
        book = Book(
            _title,
            _author,
            _price,
            _available
        );
    }
}
