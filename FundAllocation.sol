// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract FundAllocation {
    mapping(address => uint256) public funds;

    event FundsAllocated(address indexed to, uint256 amount);
    event FundsTracked(address indexed by, uint256 amount);

    // Allocate funds to an address
    function allocateFunds(address recipient, uint256 amount) public {
        funds[recipient] += amount;
        emit FundsAllocated(recipient, amount);
    }

        // Track funds of an address
    function getFunds(address recipient) public view returns (uint256) {
        return funds[recipient];
    }

    function sendAmount(address recipient, uint256 amountToSend) public {
        emit FundsAllocated(recipient, amountToSend);
    }

}
