// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.18;

import {Test} from "forge-std/Test.sol";
import {OurToken} from "../src/OurToken.sol";
import {DeployOurToken} from "../script/OurToken.s.sol";

contract OurTokenTest is Test {
    DeployOurToken public deployer;
    OurToken public ourToken;
    address bob = makeAddr("bob");
    address alice = makeAddr("alice");

    function setUp() public {
        deployer = new DeployOurToken();
        ourToken = deployer.run();
        vm.prank(msg.sender);
        ourToken.transfer(bob, 100 ether);
    }

    function testBobBalance() public {
        assertEq(100 ether, ourToken.balanceOf(bob));
    }
}
