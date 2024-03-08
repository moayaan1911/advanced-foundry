// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.18;

contract ManualToken {
    mapping(address => uint) private balances;

    constructor() {}

    function name() public pure returns (string memory) {
        return "Manual Token";
    }

    function totalSupply() public pure returns (uint256) {
        return 100 ether;
    }

    function decimals() public pure returns (uint8) {
        return 18;
    }

    function balanceOf(address _owner) public view returns (uint256) {
        return balances[_owner];
    }

    function transfer(address _to, uint256 _amount) public {
        uint256 previousBalances = balanceOf(msg.sender) + balanceOf(_to);
        balances[msg.sender] -= _amount;
        balances[_to] += _amount;
        require(balances[msg.sender] + balances[_to] == previousBalances); // asserting that the combined balances are STILL SAME
    }
}
