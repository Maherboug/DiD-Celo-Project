require("@nomicfoundation/hardhat-toolbox");
require("dotenv").config()
require("@nomiclabs/hardhat-etherscan")
require("@nomiclabs/hardhat-ethers");
require("@typechain/hardhat");
require("hardhat-celo");
require("hardhat-gas-reporter")
require("solidity-coverage")
const mnemonicPath = "m/44'/52752'/0'/0"; // derivation path used by Celo
const PRIVATE_KEY=process.env.PRIVATE_KEY;
// This is the mnemonic used by celo-devchain
const DEVCHAIN_MNEMONIC =
    "concert load couple harbor equip island argue ramp clarify fence smart topic";

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  defaultNetwork:"alfajores",
  networks: {
    localhost: {
        url: "http://127.0.0.1:8545",
        accounts: {
            mnemonic: DEVCHAIN_MNEMONIC,
        },
    },
    alfajores: {
        url: "https://alfajores-forno.celo-testnet.org",
        accounts: [process.env.PRIVATE_KEY],
        chainId: 44787,
    },
    celo: {
        url: "https://forno.celo.org",
        accounts: [process.env.PRIVATE_KEY],
        chainId: 42220,
    },
},
etherscan: {
    apiKey: {
        alfajores: process.env.CELOSCAN_API_KEY,
        celo: process.env.CELOSCAN_API_KEY,
    },
  customChains:[
    {
      network:"alfajores",
      chainId:44787,
      urls: {
        apiURL: "https://api-alfajores.celoscan.io/api",
        browserURL: "https://alfajores.celoscan.io/"
      }
    }
  ]
},
  solidity: "0.8.17",
  gasReporter:{
    enabled:true,
    outputFile:"gas-report.txt",
    noColor:true,
    currency:"USD",
    coinmarketcap:process.env.COINMARKETCAP_API_KEY,
    token:"CELO",
  }
};
