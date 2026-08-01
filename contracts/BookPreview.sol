//SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract BookPreview{
    string public bookTitle = "Unknown";

    function updateBookTitle(string memory _title) public{
        bookTitle = _title;
    }

    function previewBookTitle(string calldata _title) external pure returns(string memory){
        return _title;
    }
}