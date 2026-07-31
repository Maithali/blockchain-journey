// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract AdmissionStatus {
    enum Admission{
        Applied,
        Verified,
        Accepted,
        Rejected
    }

    Admission public status;

    function verifiedStudent() public {
       status = Admission.Verified;
    }

    function acceptStudent() public  {
        status = Admission.Accepted;
    }

    function rejectStudent() public{
        status = Admission.Rejected;
    }

    function resetStatus() public{
        status = Admission.Applied;
    }
}