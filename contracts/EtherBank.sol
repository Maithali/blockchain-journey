// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract EtherBank {

    mapping(address => uint) public balances;

    event Deposited(address indexed user, uint amount);

    event Withdrawn(address indexed user, uint amount);

    receive() external payable {
        balances[msg.sender] +=  msg.value;
        emit Deposited(msg.sender, msg.value);
    }

    function deposit() public payable {
        require( msg.value > 0, "Deposit must be greater than zero ");
        balances[msg.sender] += msg.value;
        emit Deposited(msg.sender, msg.value);
    }

    function withdraw(uint amount) public {
        require(amount > 0, "Invalid amount");
        require(balances[msg.sender] >= amount, "Insufficent user balance");

        //Update state BEFORE external call
        balances[msg.sender] -= amount;

        (bool success, ) = payable(msg.sender).call{value: amount}("");
        
        require(success, "Transfer failed");

        emit Withdrawn(msg.sender, amount);
        }

        function getMyBalance() public view returns(uint){
            return balances[msg.sender];
        }

        function getContractBalance() public view returns(uint){
            return address(this).balance;
        }

}