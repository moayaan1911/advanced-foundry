// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity 0.8.21;

import {Script} from "../lib/forge-std/src/Script.sol";
import {BasicNFT} from "../src/BasicNFT.sol";

contract DeployBasicNft is Script {
    function run() external returns (BasicNFT) {
        vm.startBroadcast();
        BasicNFT basicNFT = new BasicNFT();
        vm.stopBroadcast();
        return basicNFT;
    }
}
