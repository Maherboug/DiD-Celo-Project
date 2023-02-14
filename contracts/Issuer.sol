// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.17;

import "./PatientIdentity.sol";

contract Issuer  {

    address private   ContractOwner;
    PatientIdentity private identityContract;
    constructor(address _identityContractAddress)  {
        ContractOwner=msg.sender;
        identityContract = PatientIdentity(_identityContractAddress);

    }
    function contractOwner() public view returns (address) {
        return ContractOwner;
    }
     modifier onlyOwner() {
        if(contractOwner()!= msg.sender)
            revert Unauthorized();
         _;
     }

     event NewPatient(address patientAddress, uint mobileNumber);
    
    // function to add a new patient to the blockchain
      function addNewPatient(
        address _patientAddress,
        string memory _patientFullName,
        string memory  _dateOfbirth,
        string memory _Email,
        uint _phoneNumber,
        string memory _addressHome,
        string memory _inssuranceID,
        bytes32 _medicalRecordHash,
        string memory _medicalID,
        bool ) public  {
        // create a new patient struct
       identityContract.addPatient(_patientAddress, _patientFullName, _dateOfbirth, _Email, _phoneNumber, _addressHome, _inssuranceID, _medicalRecordHash, _medicalID,true );

        // emit the NewPatient event
       emit NewPatient(msg.sender, _phoneNumber);
    }
     event  MedicalRecordupdated(address _patientAddress, bytes32 medicalRecordHash);
      function updatMedicalRecord(
        uint _phoneNumber,
        bytes32 _medicalRecordHash)
        public  {
       identityContract.updateMedicalRecord( _phoneNumber,_medicalRecordHash);
      emit MedicalRecordupdated(msg.sender,_medicalRecordHash);
   }

    event issuedCredential(address _patientAddress, string _credentialType);

    function issueCredential(
        uint _phoneNumber,
        string memory _credentialType,
        string memory _credentialIssuer,
        string memory _credentialValue,
        string memory _dateIssued) public onlyOwner{
        
      identityContract.setCredential(_phoneNumber, _credentialType, _credentialIssuer, _credentialValue, _dateIssued, ContractOwner);
      emit  issuedCredential( ContractOwner,  _credentialType);
    }
        function viewPatientInformation(
          uint _phoneNumber
          ) 
          public view returns (string memory fullName, string memory medicalID ) {
       (fullName , medicalID)=identityContract.viewPatient(_phoneNumber);
    }
   function viewIssuedCredential( uint _phoneNumber ) public view  {
    identityContract.getIssuedCredential(_phoneNumber);
    }

}

