// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

contract Wallet {

    mapping(address => uint) private balances;

    function deposit() public payable {
        balances[msg.sender] += msg.value;
    }

    function withdraw() public {    // weak for reentrancy attack
        uint amount = balances[msg.sender];
        require(balances[msg.sender] >= amount, "Insufficient balance");
        (bool sent, ) = msg.sender.call{value: amount}("");
        require(sent, "Failed to withdraw.");
        balances[msg.sender] = 0;
    }

    function getBalance() public view returns (uint) {   // вывод баланса
        return balances[msg.sender];
    }
}
