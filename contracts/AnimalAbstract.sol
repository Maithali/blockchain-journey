// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

abstract contract AnimalAbstract {
    function makeSound() public virtual returns(string memory);
    
}

contract Dog is AnimalAbstract{
    function makeSound() public pure override returns(string memory){
        return "Woof";
    }
}