//SPDX-License-Identifier:MIT
pragma solidity ^0.8.20;

contract LoanEligibility{
    
    function checkLoanEligibility(uint _age, uint _monthlyIncome) public pure  returns (string memory){
        
        if(_age >= 21 &&  _monthlyIncome >=30000){
            return "You are eligible for loan";
        }
        else{
            return "You are not eligible for loan";
        }
    }
}