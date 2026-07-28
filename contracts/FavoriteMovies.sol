//SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract FavoriteMovies{

    string[] public movies;

    function addMovieName(string memory _movieName) public {
            movies.push(_movieName);
    }

    function removeLastMovie() public{
        movies.pop();
    }

    function totalMovies() public view returns (uint){
        return movies.length;
    }



    
}