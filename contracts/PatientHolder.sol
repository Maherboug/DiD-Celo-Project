// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.17;
import "./PatientIdentity.sol";
contract PatientHolder{
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
    event  MedicalRecordupdated(uint _phoneNumber, bytes32 medicalRecordHash );
      function updatePatientMedicalRecord(
        uint _phoneNumber,
      bytes32 _medicalRecordHash)
        public  onlyOwner {
        identityContract.updateMedicalRecord( _phoneNumber,_medicalRecordHash);
        emit MedicalRecordupdated( _phoneNumber,_medicalRecordHash);
   }
   event  authorizedProver(address _provedAddress);
    function authorizeProver(address _proverAddress) public {
      identityContract.authorizeAccess(ContractOwner,_proverAddress);
       emit  authorizedProver(_proverAddress);
    }
   event  revokedAuthorization(address _provedAddress);
    function revokeAuthorization(address _proverAddress) public {
      identityContract.revokeAccessAuthorization(ContractOwner,_proverAddress);
        emit revokedAuthorization(_proverAddress);
    }
    function viewMyCredential(uint _phoneNumber) public view  {
      identityContract.getIssuedCredential(_phoneNumber);
    }
    function viewMyInformation(
          uint _phoneNumber
          ) 
          public view returns (string memory fullName, string memory medicalID ) {
       (fullName , medicalID)=identityContract.viewPatient(_phoneNumber);
    }

}
