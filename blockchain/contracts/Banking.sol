// SPDX-License-Identifier: LicenseRef-Combs
pragma solidity ^0.8.19;

contract Banking {
    address public admin = 0x50c872f373C5468B02B1c3d014d894749f902A45;
    address public bankingAddress; // jonathancombs.base.eth resolved

    mapping(address => uint256) public balances;

    constructor() {
        bankingAddress = 0x50c872f373C5468B02B1c3d014d894749f902A45; // Placeholder
    }

    function deposit() external payable {
        balances[msg.sender] += msg.value;
    }

    function withdraw(uint256 amount) external {
        require(balances[msg.sender] >= amount, "Insufficient balance");
        balances[msg.sender] -= amount;
        payable(msg.sender).transfer(amount);
    }

    function transferTo(address to, uint256 amount) external {
        require(balances[msg.sender] >= amount, "Insufficient balance");
        balances[msg.sender] -= amount;
        balances[to] += amount;
    }
}