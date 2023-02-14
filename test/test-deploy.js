const {
  time,
  loadFixture,
} = require("@nomicfoundation/hardhat-network-helpers");
//const { anyValue } = require("@nomicfoundation/hardhat-chai-matchers/withArgs");
const { expect,assert } = require("chai");
const {ethers} =require("hardhat")

describe("PatientIentity", function () {
  let PatientIdentity, patientIdentity
  beforeEach( async function() {
     //deploying PatientIdentity.sol Contract//
     PatientIdentity=await ethers.getContractFactory("PatientIdentity")
     console.log("deploying contract PatientIdentity....")
     patientIdentity =await PatientIdentity.deploy()
     await patientIdentity.deployed()
  })
  it("should return true when patient is added ", async function() {
    const addNewPatient=await patientIdentity.addPatient(`0xa989e610298D23F41EC1080D4075b7b39c9FAcDd`,` Boughdiri Maher`,` 22/03/1997`,` Maher.boughdiri@gmail.com`, 0021642436621, `Tunisia`, ` BM67`,`0xbcc3143bc28c575568b34226721ecc4f328f0c3358a97ae73d91d3ed908b46a3`,` BM1267`, true)
    await addNewPatient.wait(1) 
    const isPatientAadded= await patientIdentity.isPatientAdded(0021642436621)
    assert.equal(isPatientAadded, true)
  }
)
}
  );
