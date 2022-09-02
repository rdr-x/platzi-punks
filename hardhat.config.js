require("@nomicfoundation/hardhat-toolbox");
require('dotenv').config()
/** @type import('hardhat/config').HardhatUserConfig */
const URL = process.env.ROPSTEN;
const PRIVATE_KEY = process.env.PRIVATE_KEY;

module.exports = {
  solidity: "0.8.9",
  networks: {
    ropsten: {
      url: URL,
      accounts: [
        PRIVATE_KEY
      ]
    }
  }
};
