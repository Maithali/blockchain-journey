//SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;    

contract EmployeeProfile{
    string public employeeName;
    uint public employeeId;
    string public employeeDepartment;

    constructor(string memory _employeeName, uint _employeeId, string memory _employeeDeparment){
        employeeName = _employeeName;
        employeeId = _employeeId;
        employeeDepartment = _employeeDeparment;
    }
}