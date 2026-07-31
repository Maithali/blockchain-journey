// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract OrderStatus{
    enum Status {
        Pending, 
        Processing,
        Shipped,
        Delivered 
    }
   Status public  orderStatus;

   function processOrder() public {
    orderStatus = Status.Processing;
   }

   function shipOrder() public {
    orderStatus = Status.Shipped;
   }

   function deliverOrder() public  {
    orderStatus = Status.Delivered;
   }

   function pendingOrder() public {
    orderStatus = Status.Pending;
   }
}