// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract FundAllocation {
    mapping(address => uint256) public funds;

    event FundsAllocated(address indexed to, uint256 amount);
    event FundsWithdrawn(address indexed from, uint256 amount);
    event FundsTransferred(address indexed from, address indexed to, uint256 amount);
    event FundsDeposited(address indexed from, uint256 amount);

    // Allocate funds to an address
    function allocateFunds(address recipient, uint256 amount) public {
        require(amount > 0, "Amount must be greater than zero");
        funds[recipient] += amount;
        emit FundsAllocated(recipient, amount);
    }

    // Get funds for an address
    function getFunds(address recipient) public view returns (uint256) {
        return funds[recipient];
    }

    // Send a specific amount to a recipient
    function sendAmount(address recipient, uint256 amountToSend) public {
        require(funds[msg.sender] >= amountToSend, "Insufficient funds");
        funds[msg.sender] -= amountToSend;
        funds[recipient] += amountToSend;
        emit FundsTransferred(msg.sender, recipient, amountToSend);
    }

    // Withdraw funds from the sender's account
    function withdrawFunds(uint256 amount) public {
        require(funds[msg.sender] >= amount, "Insufficient funds to withdraw");
        funds[msg.sender] -= amount;
        emit FundsWithdrawn(msg.sender, amount);
        payable(msg.sender).transfer(amount);
    }

    // Deposit funds to sender's account
    function depositFunds() public payable {
        require(msg.value > 0, "You must deposit some Ether");
        funds[msg.sender] += msg.value;
        emit FundsDeposited(msg.sender, msg.value);
    }

    // Transfer funds from one address to another
    function transferFunds(address recipient, uint256 amount) public {
        require(funds[msg.sender] >= amount, "Insufficient funds to transfer");
        require(msg.sender != recipient, "Cannot transfer to yourself");
        funds[msg.sender] -= amount;
        funds[recipient] += amount;
        emit FundsTransferred(msg.sender, recipient, amount);
    }
}
