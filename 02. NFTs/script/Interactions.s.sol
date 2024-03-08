// SPDX-License-Identifier:MIT
pragma solidity ^0.8.18;
import {Script, console} from "../lib/forge-std/src/Script.sol";
import {DevOpsTools} from "../lib/foundry-devops/src/DevOpsTools.sol";
import {BasicNFT} from "../src/BasicNFT.sol";

contract MintBasicNFT is Script {
    function run() external {
        address mostRecentlyDeployed = DevOpsTools.get_most_recent_deployment(
            "BasicNFT",
            block.chainid
        );
        mintNFTFunction(mostRecentlyDeployed);
    }

    function mintNFTFunction(address _mostRecentlyDeployed) public {
        vm.startBroadcast();
        BasicNFT(_mostRecentlyDeployed).mintNft(
            "ipfs://bafybeie5yp3bdojdemxwvszrx5dek2ldrs6ke3oihrwu5fdp3bfnuqpls4/"
        );
        vm.stopBroadcast();
    }
}
