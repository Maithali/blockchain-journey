// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract EmployeeRecord {

    // ==========================
    // State Variables
    // ==========================

    string private employeeName;
    uint256 private employeeId;
    uint16 private salary;
    bool private isActive;
    address private walletAddress;
    bytes32 private departmentCode;

    // ==========================
    // Employee Name
    // ==========================

    function setEmployeeName(string memory _employeeName) public {
        employeeName = _employeeName;
    }

    function getEmployeeName() public view returns (string memory) {
        return employeeName;
    }

    // ==========================
    // Employee ID
    // ==========================

    function setEmployeeId(uint256 _employeeId) public {
        employeeId = _employeeId;
    }

    function getEmployeeId() public view returns (uint256) {
        return employeeId;
    }

    // ==========================
    // Salary
    // ==========================

    function setSalary(uint16 _salary) public {
        salary = _salary;
    }

    function getSalary() public view returns (uint16) {
        return salary;
    }

    // ==========================
    // Employee Status
    // ==========================

    function setIsActive(bool _isActive) public {
        isActive = _isActive;
    }

    function getIsActive() public view returns (bool) {
        return isActive;
    }

    // ==========================
    // Wallet Address
    // ==========================

    function setWalletAddress(address _walletAddress) public {
        walletAddress = _walletAddress;
    }

    function getWalletAddress() public view returns (address) {
        return walletAddress;
    }

    // ==========================
    // Department Code
    // ==========================

    function setDepartmentCode(bytes32 _departmentCode) public {
        departmentCode = _departmentCode;
    }

    function getDepartmentCode() public view returns (bytes32) {
        return departmentCode;
    }
}