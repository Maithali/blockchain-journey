//SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract DynamicArray {
    string[] public  students;

    function addStudent(string memory _name) public {
        students.push(_name);
    }
    
    function removeLastStudent() public {
        students.pop();
    }

    function totalStudents() public view returns(uint){
        return students.length;
    }
}