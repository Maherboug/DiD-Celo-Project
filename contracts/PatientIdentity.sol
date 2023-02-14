// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.17;

error Unauthorized();
error IsExist(uint _phoneNumber);
error IsNotExist(uint _phoneNumber);
contract PatientIdentity {
    // patient struct
    struct Patient {
        address patientAddress;       
        string fullName;
        string dateOfBirth;
        string emailAddress;
        uint mobileNumber;
        string houseAddress;
        string inssuranceID;
        bytes32 medicalRecordHash;
        string medicalRecordID;
        bool isAdded;
    }
    // credential struct
    struct Credential {
        address issuerAddress;
        string credentielType;
        string credentialIssuer;
        string credentialValue;
        string dateIssued;
    }
    address[] public issuerAddresses;

    // mapping of patient addresses to patient structs
    mapping(address => Patient) public patients;
    // mapping of patient addresses to arrays of credentials
    mapping(address => Credential[]) public credentials; 
    //mapping phone number to patient address 
    mapping(uint => address) public phoneNumberToPatient;

     // mapping of patient addresses to lists of authorized provers
    mapping(address => mapping(address => bool)) public authorizedProvers; 

    address private  ContractOwner;
    constructor() {
        ContractOwner = msg.sender;
    }

    function owner() public view returns (address) {
        return ContractOwner;
    }
     function isPatientAdded(uint _phoneNumber) public view returns (bool) {
        address _patientAddress = phoneNumberToPatient[_phoneNumber];
        return patients[_patientAddress].isAdded;
    } 
    function isAuthorized(uint _phoneNumber, address _proverAddress) public view returns (bool) {
        address _patientAddress = phoneNumberToPatient[_phoneNumber];
        return authorizedProvers[_patientAddress][_proverAddress] ;
    } 
    modifier onlyOwner() {
        if(owner() != msg.sender)
            revert Unauthorized();
         _;
    }
    modifier isAdded(uint _phoneNumber){
    if(isPatientAdded( _phoneNumber)== false)
        revert IsExist( _phoneNumber);
     _;
    }
    modifier isNotAdded(uint _phoneNumber){
    if(isPatientAdded( _phoneNumber)== true)
        revert IsNotExist( _phoneNumber);
     _;
    }

    function addPatient(
        address _patientAddress,
        string memory _patientFullName,
        string memory  _dateOfbirth,
        string memory _Email,
        uint _phoneNumber,
        string memory _addressHome,
        string memory _inssuranceID,
        bytes32 _medicalRecordHash,
        string memory _medicalID,
        bool ) public {
        Patient memory newPatient= Patient(
          _patientAddress,
          _patientFullName,
          _dateOfbirth,
          _Email,
          _phoneNumber,
          _addressHome,
          _inssuranceID,
          _medicalRecordHash,
          _medicalID,true);
        // add the new patient to the mapping
        patients[ _patientAddress] = newPatient;
        phoneNumberToPatient[_phoneNumber] = _patientAddress;
        }

    function updateMedicalRecord(
        uint _phoneNumber,
      bytes32 _medicalRecordHash)
        public  onlyOwner isAdded( _phoneNumber) {
          address _patientAddress = phoneNumberToPatient[_phoneNumber];
          patients[_patientAddress].medicalRecordHash = _medicalRecordHash;
        }
    function viewPatient(
          uint _phoneNumber
          ) 
          public  view returns (
          string memory, string memory)
           {
        address _patientAddress = phoneNumberToPatient[_phoneNumber];
        Patient storage patient = patients[_patientAddress];
    return (patient.fullName,patient.medicalRecordID);
           }
    function getIssuedCredential( uint _phoneNumber ) public view returns (Credential[] memory) {
         address _patientAddress = phoneNumberToPatient[_phoneNumber];
     return  credentials[_patientAddress];
    }
    function authorizeAccess(address _patientAddress, address _proverAddress) public {
        authorizedProvers[_patientAddress][_proverAddress]=true;
    }
    function revokeAccessAuthorization(address  _patientAddress,address _proverAddress) public {
         authorizedProvers[_patientAddress][_proverAddress] = false;
       
    }
    function setCredential(
        uint _phoneNumber,
        string memory _credentialType,
        string memory _credentialIssuer,
        string memory _credentialValue,
        string memory _dateIssued,
        address _issuerAddresse) public {
        address _patientAddress =  phoneNumberToPatient[_phoneNumber];
        Credential memory newCredential = Credential(_issuerAddresse,_credentialType, _credentialIssuer, _credentialValue, _dateIssued);
     // add the new credential to the patient's list of issued credentials
        credentials[_patientAddress].push(newCredential);
       issuerAddresses.push(_issuerAddresse);
    }


 }