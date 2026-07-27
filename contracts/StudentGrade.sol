//SPDX-License-Identifier:MIT
pragma solidity ^0.8.20;

contract  StudentGrade{

function gradeChecker(uint _marks) public pure returns(string memory){

    if(_marks >= 90){
        return "Grade A";
    }
    else if(_marks >= 75){
        return "Grade B";
    }
    else if(_marks >= 60){
        return "Grade C";
    }
    else if(_marks >= 35){
        return "Grade D";
    }
    else{
        return "Fail";
    }
}

}