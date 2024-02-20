// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract CoinFlip is Ownable {
    
    ERC20 public token;
    uint256 public betAmount = 0.1 ether;
    
    event BetResult(address indexed player, uint256 amount, bool result);
    
    constructor(address tokenAddress) {
        token = ERC20(tokenAddress);
    }
    
    // Function to set the betting amount
    function setBetAmount(uint256 amount) external onlyOwner {
        betAmount = amount;
    }
    
    // Function to allow players to bet by sending tokens
    function bet() external {
        require(token.balanceOf(msg.sender) >= betAmount, "Insufficient balance");
        
        // Actual coin flip logic (this is a dummy example)
        bool result = block.timestamp % 2 == 0;
        
        if (result) {
            // Reward the player with double the bet amount
            token.transfer(msg.sender, betAmount * 2);
        }
        
        emit BetResult(msg.sender, betAmount, result);
    }
}