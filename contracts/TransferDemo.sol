// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract TransferDemo {
    receive() external payable {}

    function withdraw(uint amount) public {
        require(address(this).balance >= amount,"Insufficient balance");
        payable(msg.sender).transfer(amount);
    }

    function getBalance() public view returns(uint){
        return address(this).balance;
    }
}