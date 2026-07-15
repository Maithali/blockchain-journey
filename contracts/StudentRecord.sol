// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract StudentRecord {
    
    // 1. Defining what data a Student has
    struct Student {
        uint256 id;
        string name;
        uint8 age;
        string course;
        bool isRegistered;
    }

    // 2. State Variables (Stored permanently on the blockchain)
    mapping(uint256 => Student) private students;

    // 3. Events to notify the outside world (DApps/Frontends)
    event StudentAdded(uint256 indexed id, string name);
    event StudentUpdated(uint256 indexed id, string name);
    event StudentDeleted(uint256 indexed id);

    // 4. Feature: Add Student
    function addStudent(uint256 _id, string memory _name, uint8 _age, string memory _course) public {
        require(!students[_id].isRegistered, "Student ID already exists!");
        require(_id > 0, "ID must be greater than 0");
        require(_age > 0, "Age must be greater than 0");

        students[_id] = Student(_id, _name, _age, _course, true);
        
        emit StudentAdded(_id, _name);
    }

    // 5. Feature: View Student (Read-only)
    function viewStudent(uint256 _id) public view returns (uint256 id, string memory name, uint8 age, string memory course) {
        require(students[_id].isRegistered, "Student does not exist!");
        Student memory s = students[_id];
        return (s.id, s.name, s.age, s.course);
    }

    // 6. Feature: Update Student
    function updateStudent(uint256 _id, string memory _newName, uint8 _newAge, string memory _newCourse) public {
        require(students[_id].isRegistered, "Student does not exist!");
        require(_newAge > 0, "Age must be greater than 0");

        students[_id].name = _newName;
        students[_id].age = _newAge;
        students[_id].course = _newCourse;

        emit StudentUpdated(_id, _newName);
    }

    // 7. Feature: Delete Student
    function deleteStudent(uint256 _id) public {
        require(students[_id].isRegistered, "Student does not exist!");
        
        // delete completely clears the data slot and resets it to default values
        delete students[_id];

        emit StudentDeleted(_id);
    }
}