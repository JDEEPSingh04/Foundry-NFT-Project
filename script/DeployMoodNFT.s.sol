// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Script,console} from "forge-std/Script.sol";
import {MoodNFT} from "../src/MoodNFT.sol";
import {Base64} from "lib/openzeppelin-contracts/contracts/utils/Base64.sol";

contract DeployMoodNFT is Script{
    MoodNFT nft;
    function run() external returns(MoodNFT){
        string memory Happy=vm.readFile("./images/dynamicNft/happy.svg");
        string memory Sad=vm.readFile("./images/dynamicNft/sad.svg");
        vm.startBroadcast();
        nft=new MoodNFT(svgToImageURI(Happy),svgToImageURI(Sad));
        vm.stopBroadcast();
        return nft;
    }

    function svgToImageURI(
        string memory svg
    ) public pure returns (string memory) {
        string memory baseURL = "data:image/svg+xml;base64,";
        string memory svgBase64Encoded = Base64.encode(
            bytes(abi.encodePacked(svg))
        );
        return string(abi.encodePacked(baseURL, svgBase64Encoded));
    }
}