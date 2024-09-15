// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import {ERC20Burnable, ERC20} from "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";

/**
@title Decentralized Stable Coin
@dev Implementation of Decentralized Stable Coin
@author moayaan.eth
 */
contract DecentralizedStableCoinContract is ERC20Burnable, Ownable {
    constructor() ERC20("DecentralizedStableCoin", "DSC") Ownable(msg.sender) {}

    function burn(uint256 _amount) public override onlyOwner {
        uint256 balanceOfUser = balanceOf(msg.sender);
        if (_amount <= 0) {
            revert("Amount should be greater than 0");
        }
        if (balanceOfUser < _amount) {
            revert("Burn amount should be less than balance");
        }
        super.burn(_amount);
    }

    function mint(
        address _to,
        uint256 _amount
    ) external onlyOwner returns (bool) {
        if (_to == address(0)) {
            revert("To address should not be zero");
        }
        if (_amount <= 0) {
            revert("Amount should be greater than 0");
        }
        _mint(_to, _amount);
        return true;
    }
}
