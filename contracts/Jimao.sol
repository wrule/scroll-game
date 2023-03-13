// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract JIMAO is ERC20 {
  constructor()
  ERC20("Jimao Token", "JIMAO") {
    _mint(address(this), total_supply);
  }

  uint private constant total_supply =  1e18 * 1e18;
  uint private constant airdrop_amount = 1e18 * 100;

  function airdrop()
  public {
    require(this.balanceOf(address(this)) >= airdrop_amount, "error");
    this.transfer(msg.sender, airdrop_amount);
  }
}
