// SPDX-License-Identifier: LicenseRef-Combs
pragma solidity ^0.8.19;

contract CombsToken {
    string public name = "Combs Token";
    string public symbol = "COMBS";
    uint8 public decimals = 18;
    uint256 public totalSupply;

    address public owner = 0x50c872f373C5468B02B1c3d014d894749f902A45;
    address public bankingAddress; // To be set to resolved jonathancombs.base.eth

    mapping(address => uint256) public balanceOf;
    mapping(address => mapping(address => uint256)) public allowance;

    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value);

    constructor() {
        totalSupply = 1000000 * 10**decimals;
        balanceOf[owner] = totalSupply;
        bankingAddress = 0x50c872f373C5468B02B1c3d014d894749f902A45; // Placeholder, resolve ENS in deployment
    }

    function transfer(address to, uint256 value) public returns (bool) {
        require(balanceOf[msg.sender] >= value, "Insufficient balance");
        balanceOf[msg.sender] -= value;
        balanceOf[to] += value;
        emit Transfer(msg.sender, to, value);
        return true;
    }

    function approve(address spender, uint256 value) public returns (bool) {
        allowance[msg.sender][spender] = value;
        emit Approval(msg.sender, spender, value);
        return true;
    }

    function transferFrom(address from, address to, uint256 value) public returns (bool) {
        require(balanceOf[from] >= value, "Insufficient balance");
        require(allowance[from][msg.sender] >= value, "Allowance exceeded");
        balanceOf[from] -= value;
        balanceOf[to] += value;
        allowance[from][msg.sender] -= value;
        emit Transfer(from, to, value);
        return true;
    }

    // Function to trade tokens to USD equivalent (simplified)
    function tradeToUSD(uint256 amount) public {
        require(balanceOf[msg.sender] >= amount, "Insufficient balance");
        // Assume 1 COMBS = 1 USD for simplicity
        balanceOf[msg.sender] -= amount;
        totalSupply -= amount;
        // In real, interact with DEX or MakerDAO
        emit Transfer(msg.sender, address(0), amount);
    }

    // Banking function, send to banking address
    function depositToBank(uint256 amount) public {
        transfer(bankingAddress, amount);
    }
}