const { ethers } = require("hardhat");

async function main() {
    const [deployer] = await ethers.getSigners();

    console.log("Deploying contracts with the account:", deployer.address);

    const CombsToken = await ethers.getContractFactory("CombsToken");
    const token = await CombsToken.deploy();
    await token.deployed();
    console.log("CombsToken deployed to:", token.address);

    const SmartWallet = await ethers.getContractFactory("SmartWallet");
    const wallet = await SmartWallet.deploy();
    await wallet.deployed();
    console.log("SmartWallet deployed to:", wallet.address);

    const Banking = await ethers.getContractFactory("Banking");
    const banking = await Banking.deploy();
    await banking.deployed();
    console.log("Banking deployed to:", banking.address);
}

main()
    .then(() => process.exit(0))
    .catch((error) => {
        console.error(error);
        process.exit(1);
    });