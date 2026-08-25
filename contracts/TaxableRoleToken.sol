// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/AccessControl.sol";

contract TaxableRoleToken is ERC20, AccessControl {
    bytes32 public constant MINTER_ROLE = keccak256("MINTER_ROLE");
    address public feeCollector;
    uint256 public constant FEE_PERCENT = 1; // 1% tax on transfers

    constructor(address defaultAdmin, address minter, address _feeCollector) 
        ERC20("TaxToken", "TAX") 
    {
        _grantRole(DEFAULT_ADMIN_ROLE, defaultAdmin);
        _grantRole(MINTER_ROLE, minter);
        feeCollector = _feeCollector;
    }

    function mint(address to, uint256 amount) public {
        require(hasRole(MINTER_ROLE, msg.sender), "Caller is not a minter");
        _mint(to, amount);
    }

    // Custom transfer logic to take a 1% fee on normal user transfers
    function _update(address from, address to, uint256 value) internal override {
        // Skip tax during minting, burning, or transfers to/from fee collector
        if (from == address(0) || to == address(0) || from == feeCollector || to == feeCollector) {
            super._update(from, to, value);
            return;
        }

        uint256 fee = (value * FEE_PERCENT) / 100;
        uint256 sendAmount = value - fee;

        super._update(from, feeCollector, fee);
        super._update(from, to, sendAmount);
    }
}