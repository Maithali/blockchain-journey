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

/*
In the input box next to the Deploy button (labeled initialOwner), paste that address.
 then deploy
 1)Click owner -> verifies your deployer address
 2)Click totalSupply-> shows 500000000000000000000000 
 3)Paste your deployer address into balanceOf -> confirms you hold all 500,000 initial tokens.
 4)Mint new tokens (Owner Only)
    . account#2 address copy paste in to address and amount transact. only owner can mint.
    Check balanceOf(Account #2).
    check total amount it has increased.

    Test owner restriction security
    Switch your active Account dropdown at the top to Account #2 (a non-owner).
    Try to call mint to give any address more tokens.
    Click transact -> the transaction reverts with an OwnableUnauthorizedAccount error because Account #2 is not the owner.
5) 5.Burn tokens (Using ERC20Burnable):Stay logged into Account #2.
   Expand burn.In amount: enter amount.
   Click transact.
   Re-check balanceOf(Account #2) -> drops.
    totalSupply permanently drops.
    */
