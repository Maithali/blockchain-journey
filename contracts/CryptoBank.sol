// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract CryptoBank {
    mapping(address => uint) public balances;

    event Deposited(address indexed user, uint amount);

    receive() external payable {
        balances[msg.sender] += msg.value;

        emit Deposited(msg.sender, msg.value);
    }

    function deposit() public payable{
        require(msg.value > 0, "Deposit must be greater than zero");

        balances[msg.sender] += msg.value;

        emit Deposited(msg.sender, msg.value);
    }

    function getMyBalance() public view returns(uint){
        return balances[msg.sender];
    }

    function getContractBalance() public view returns(uint){
        return address(this).balance;
    }
}