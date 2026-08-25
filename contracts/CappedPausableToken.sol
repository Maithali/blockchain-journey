// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Capped.sol";
import "@openzeppelin/contracts/utils/Pausable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract CappedPausableToken is ERC20Capped, Pausable, Ownable {
    constructor(uint256 cap, address initialOwner) 
        ERC20("SecureToken", "SEC") 
        ERC20Capped(cap * 10 ** decimals()) 
        Ownable(initialOwner) 
    {}

    function pause() public onlyOwner {
        _pause();
    }

    function unpause() public onlyOwner {
        _unpause();
    }

    function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }

    // Overriding transfer updates to enforce pause rules and cap limits
    function _update(address from, address to, uint256 value) 
        internal 
        override(ERC20, ERC20Capped) 
    {
        require(!paused(), "Token: token transfer while paused");
        super._update(from, to, value);
    }
}