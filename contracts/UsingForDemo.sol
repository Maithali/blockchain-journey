// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

library NumberLibrary{
    function double(uint number) internal pure returns(uint){
        return number * 2;
    }

    function triple(uint number) internal pure returns(uint){
        return number * 3;
    }
}

contract NumberCalculator {
    using NumberLibrary for uint;

    function getDouble(uint number) public  pure returns(uint){
        return number.triple();
    }
}