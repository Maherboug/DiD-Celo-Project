
# Decentralized Identity Management (DID)
Decentralized identity is a form of identity management that gives users the freedom to manage their own online personas without being reliant on a single service provider.

This system uses the Celo blockchain, which enables secure, open, and decentralized storage and sharing of patient identity data without the need for a central authority or intermediary. Therefore, a patient can use a digital wallet installed on a phone to safely store and manage its digital identity and credentials.

This system manges patient identity throw 4 smart contracts: 
- PatientIdentity.sol: defines the digital data associated with a patient identity and the management functions for that identity.
- PatientHolder.sol : The patient can manage their identity through this contract by updating their information, authorizing a prover, revoking authorization, and viewing their information.
- Prover.sol: this contract permits a prover ( healthcare organization, doctor, ...)  to confirm patient information (if this prover is authorized by the patient). 
- Issuer.sol : allow a healthcare organization to issue credentials to a patient (add a new patient, issue a new credential to them, and update their related information).


# Requirements​

To get started, ensure you have the following tools installed on the machine:

- Code editor. VSCode recommended.
- NodeJs version >=14.0.0.
- solc compiler 0.8.0
- yarn or npm 
 # Hardhat 
 Hardhat is a development environment to compile, deploy, test, and debug your Ethereum or Celo software. It helps developers manage and automate the recurring tasks that are inherent to the process of building smart contracts and dApps, as well as easily introducing more functionality around this workflow. This means compiling, running, and testing smart contracts at the very core.

 # MetaMask 

  MetaMask, the world’s most popular non-custodial digital wallet and Web3 gateway for desktop and mobile.   It provides a secure means to connect to blockchain-based applications. Using MetaMask with Celo makes it quick and easy to access the Celo dApps with this powerful crypto wallet. Before getting start, verify that metamask is installed and Add the Celo network ( celo mainnet and Alfajores Testnet ) details to MetaMask.

# Quickstart

```
git clone https://github.com/MaherBough
cd hardhat-simple-storage-fcc
yarn
yarn hardhat
```

# .env 
 Before deploying project on celo blockchain create a ```.env``` file  similar to ```.env.example```  


 # Deploy to Celo

 ## Compile:

 Run the following command from your root project directory to compile project 
 ```
yarn hardhat compile
 ``` 
## Deploy:  

Run the following command from your root project directory to deploy to Celo Alfajores testnet.
(alfajores  is the default network)
```
yarn hardhat run scripts/deploy.js --network alfajores
```
...or run this command to deploy to Celo mainnet.
```
yarn hardhat run scripts/deploy.js  --network celo
```

## Testing: 
Run the following command from your root project directory to test contracts  Celo Alfajores testnet.

```
yarn hardhat test
```

For the test coverage 

```
yarn hardhat coverage
```

## Estimate gas
You can estimate how much gas things cost by running:
```
yarn hardhat test
```
And you'll see and output file called ```gas-report.txt```


## verify on celoscan
If you deploy to a testnet or mainnet, you can verify it if you get an API Key from ```celoscan``` and set it as an environment variable named ```CELOSCAN_API_KEY```. You can pop it into your .env file as seen in the .env.example.


## Manual verification 
you can manual verify with:
```
yarn hardhat verify --constructor-args arguments.js DEPLOYED_CONTRACT_ADDRESS
```

