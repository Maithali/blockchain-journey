// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract SimpleToken is ERC20 {
    // Mint 1,000,000 tokens to the contract deployer on creation
    // 10**18 accounts for 18 decimal places
    constructor() ERC20("SimpleToken", "SIM") {
        _mint(msg.sender, 1000000 * 10 ** decimals());
    }
}


/*

Interact with the deployed contract
    1)Click name, symbol, or totalSupply
    2)Copy the address in account field and paste in balance of.
    3)Expand transfer, paste a different account address click transact.
    4)approve Put Account #2's address in spender and amount.
    5)allowance Put Account #1 in owner and Account #2 in spender.
    6)Change your active Remix Account dropdown to Account #2
    Expand transferFrom. Put Account #1 in from, Account #2 in to, and 50000000000000000000 (50 tokens) in value.

    */