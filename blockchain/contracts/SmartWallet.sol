// SPDX-License-Identifier: LicenseRef-Combs
pragma solidity ^0.8.19;

contract SmartWallet {
    address public owner = 0x50c872f373C5468B02B1c3d014d894749f902A45;

    modifier onlyOwner() {
        require(msg.sender == owner, "Not owner");
        _;
    }

    function execute(address to, uint256 value, bytes calldata data) external onlyOwner {
        (bool success,) = to.call{value: value}(data);
        require(success, "Execution failed");
    }

    receive() external payable {}
}