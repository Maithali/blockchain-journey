// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

abstract contract Employee {
    string public company = "Blockchain Company";

    function getRole() public virtual returns(string memory);

    function getCompany() public view returns(string memory){
        return company;
    }


}

contract Developer is Employee {
    function getRole() public pure override returns(string memory){
        return "Blockchain Developer";
    }
}