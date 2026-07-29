//SPDX-License-Idtifier: MIT
pragma solidity ^0.8.20;

contract CarInformation{
    struct Car{
        string brand;
        string model;
        uint year;
         bool isElectic;
    }

    Car public car;

    function setCar(string memory _brand, string memory _model, uint _year, bool _isElectic) public {
        car = Car(_brand, _model, _year, _isElectic);

    }
}