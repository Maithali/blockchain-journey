// SPDX-License-Ientifier: MIT
pragma solidity ^0.8.20;

abstract contract Shape{
    function area(uint value) public virtual returns(uint);

}

contract Square is Shape {
    function area(uint value) public pure override returns(uint){
        return value + value;
    }
}