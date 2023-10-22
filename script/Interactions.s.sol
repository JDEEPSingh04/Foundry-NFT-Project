// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {BasicNFT} from "../src/BasicNFT.sol";
import {DeployBasicNFT} from "../script/DeployBasicNFT.s.sol";
import {Script} from "forge-std/Script.sol";
import {DevOpsTools} from "lib/foundry-devops/src/DevOpsTools.sol";

contract MintBasicNFT is Script {
    string public constant URI =
        "ipfs://bafybeig37ioir76s7mg5oobetncojcm3c3hxasyd4rvid4jqhy4gkaheg4/?filename=0-PUG.json";

    function run() external {
        address MostRecentDeployed = DevOpsTools.get_most_recent_deployment(
            "BasicNFT",
            block.chainid
        );
        mintNFTonContract(MostRecentDeployed);
    }

    function mintNFTonContract(address MostRecentDeployed) public {
        vm.startBroadcast();
        BasicNFT(MostRecentDeployed).mintNFT(URI);
        vm.stopBroadcast();
    }
}
