// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.17;

import "./PatientIdentity.sol";

 contract Prover {
   address private ContractOwner;
    PatientIdentity public  identityContract;
    constructor(address _identityContractAddress) {
        ContractOwner = msg.sender;
        identityContract = PatientIdentity(_identityContractAddress);
    }

        function contractOwner() public view returns (address) {
        return ContractOwner;
    }
     modifier onlyOwner() {
        if(contractOwner() != msg.sender)
            revert Unauthorized();
         _;
     }
    function verifyPatient(
        uint _phoneNumber
        ) 
        public view  returns (string memory,  string memory) {
      //  address _patientAddress = phoneNumberToPatient[_phoneNumber];
        if(identityContract.isAuthorized(_phoneNumber, ContractOwner))
         revert Unauthorized();
        return identityContract.viewPatient( _phoneNumber);
    }
}