//imports
const { TransactionDescription } = require("@ethersproject/abi")
const {ethers,run,network}=require("hardhat")
const PatientIdentity = require("../artifacts/contracts/PatientIdentity.sol/PatientIdentity.json");
//async main 
async function main() {
 
 
 //deploying PatientIdentity.sol Contract//
 const PatientIdentity=await ethers.getContractFactory("PatientIdentity")
 console.log("deploying contract PatientIdentity....")
 const patientIdentity =await PatientIdentity.deploy()
 await patientIdentity.deployed()
 console.log(`deployed contract to: ${patientIdentity.address}`)
 console.log(network.config)
 //Deploying PatientHolder.sol contract/////////
 const PatientHolder= await ethers.getContractFactory("PatientHolder")
 console.log("deploying contract PatientHolder....")
 const patientHolder =await PatientHolder.deploy(patientIdentity.address)
 await patientHolder.deployed()
 console.log(`deployed contract to: ${patientHolder.address}`)
 console.log(network.config)
 //deploying issuer.sol contract 
 
 const Issuer= await ethers.getContractFactory("Issuer")
 console.log("deploying contract Issuer....")
 const issuer =await PatientHolder.deploy(patientIdentity.address)
 await issuer.deployed()
 console.log(`deployed contract to: ${issuer.address}`)
 console.log(network.config)
 
 // deploying prover.sol contract////////////////////////////////

 const Prover= await ethers.getContractFactory("Prover")
 console.log("deploying contract Prover....")
 const prover =await PatientHolder.deploy(patientIdentity.address)
 await prover.deployed()
 console.log(`deployed contract to: ${prover.address}`)
 console.log(network.config)
// verify PatientIdentity contract on celo exploer 
 if(network.config.chainId===44787&& process.env.CELOSCAN_API_KEY){
    console.log("waiting for block txes...")
    const addNPatient=await patientIdentity.addPatient(`0xa989e610298D23F41EC1080D4075b7b39c9FAcDd`,` Boughdiri Maher`,` 22/03/1997`,` Maher.boughdiri@gmail.com`, 0021642436621, `Tunisia`, ` BM67`,`0xbcc3143bc28c575568b34226721ecc4f328f0c3358a97ae73d91d3ed908b46a3`,` BM1267`, true)
    await addNPatient.wait(1) 
   // await patientIdentity.deployTransaction.wait(1)
    await verify(patientIdentity.address,[])
  }

// interacting with  deployed contracts 
 const addNewPatient=await patientIdentity.addPatient(`0xa989e610298D23F41EC1080D4075b7b39c9FAcDd`,` Boughdiri Maher`,` 22/03/1997`,` Maher.boughdiri@gmail.com`, 0021642436621, `Tunisia`, ` BM67`,`0xbcc3143bc28c575568b34226721ecc4f328f0c3358a97ae73d91d3ed908b46a3`,` BM1267`, true)
 await addNewPatient.wait(1) 
 const isPatientAadded= await patientIdentity.isPatientAdded(0021642436621)
 console.log(`Added Patient is  : ${isPatientAadded}`)

 const NewCredentials = await issuer.issueCredential(0021642436621,`COVID test`, `Hospital A`, `Sinopharm`, `22/03/1997`)
 await NewCredentials.wait(1)
 const credential= await issuer.viewIssuedCredential(0021642436621)
 console.log(`Issued credential are: ${credential}`)
}
async function verify(contractAddress, args) {
  console.log("verifying contract ...")
 try{
    await run("verify:verify",{
      address: contractAddress,
      constructorArgs: args,
    })}
  catch(e){
    if (e.message.toLowerCase().includes("already verified"))
    console.log("already verified")
    else{
      console.log(e)
    }
  } 
}

//main 
main () 
  .then(() => {process.exit(0)})
  .catch((error) => {
    console.error(error)
    process.exit(1)})