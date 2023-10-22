// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Script,console} from "forge-std/Script.sol";
import {DevOpsTools} from "lib/foundry-devops/src/DevOpsTools.sol";
import {DeployMoodNFT} from "./DeployMoodNFT.s.sol";
import {MoodNFT} from "../src/MoodNFT.sol";

contract MintMoodNFT is Script{
    function run() external{
        address MostRecent=DevOpsTools.get_most_recent_deployment("MoodNFT",block.chainid);
        Mint(MostRecent);
    }
    function Mint(address MostRecent) internal{
        vm.startBroadcast();
        MoodNFT(MostRecent).mintNFT();
        vm.stopBroadcast();
    }
}

contract FlipMoodNFT is Script{
    function run() external{
        address MostRecent=DevOpsTools.get_most_recent_deployment("MoodNFT",block.chainid);
        Flip(MostRecent);
    }
    function Flip(address MostRecent) internal{
        vm.startBroadcast();
        MoodNFT(MostRecent).flipMood(0);
        vm.stopBroadcast();
    }
}