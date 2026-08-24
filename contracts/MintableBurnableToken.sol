// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract MintableBurnableToken is ERC20, ERC20Burnable, Ownable {
    constructor(address initialOwner) 
        ERC20("UtilityToken", "UTIL") 
        Ownable(initialOwner) 
    {
        _mint(msg.sender, 500000 * 10 ** decimals());
    }

    // Only the contract owner can call this function to mint new tokens
    function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }
}