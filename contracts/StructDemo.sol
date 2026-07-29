//SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract StructDemo {
    struct Student{
        string name;
        uint age;
        string course;
    }

    Student public student;

    function setStudent(string memory _name, uint _age, string memory _course) public {
        student = Student(
            _name,
            _age,
            _course
        );
    }
 }