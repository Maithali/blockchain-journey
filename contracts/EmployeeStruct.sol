//SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;


contract  EmployeeStruct {
    struct  Employee{

        string name;
        uint id;
        uint salary;
        bool isActive;

    }

    Employee public employee;

    function setEmployee(string memory _name, uint _id, uint _salary, bool _isActive) public{
        employee = Employee(
            _name,
            _id,
            _salary,
            _isActive
        );
    }
}