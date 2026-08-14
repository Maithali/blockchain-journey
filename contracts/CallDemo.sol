// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract CallDemo{
  receive() external payable {}

  function withdraw(uint amount) public{
    require(address(this).balance >= amount,"Insufficent balance");

    (bool success,) = payable(msg.sender).call{value: amount}("");

    require(success, "Ether transfer failed");    
      }   

    function getBalance() public view returns(uint){
        return address(this).balance;
    }
}