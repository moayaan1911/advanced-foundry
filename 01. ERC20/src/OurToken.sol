// SPDX-License-Identifier: SEE LICENSE IN LICENSE
import "../lib/openzeppelin-contracts/contracts/token/ERC20/ERC20.sol";
pragma solidity ^0.8.18;

contract OurToken is ERC20 {
    constructor(uint256 _initialSupply) ERC20("Our Token", "OT") {
        _mint(msg.sender, _initialSupply);
    }
}
