// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Test, console} from "forge-std/Test.sol";
import {DeployBasicNFT} from "../script/DeployBasicNFT.s.sol";
import {BasicNFT} from "../src/BasicNFT.sol";

contract BasicNFTTest is Test {
    DeployBasicNFT public deployer;
    BasicNFT nft;
    address public USER=makeAddr("USER");
    string public constant URI="ipfs://bafybeig37ioir76s7mg5oobetncojcm3c3hxasyd4rvid4jqhy4gkaheg4/?filename=0-PUG.json";

    function setUp() public {
        deployer = new DeployBasicNFT();
        nft = deployer.run();
    }

    function testName() public view {
        string memory ExpectedName = "Doggie";
        string memory TrueName = nft.name();
        assert(keccak256(abi.encodePacked(ExpectedName))==keccak256(abi.encodePacked(TrueName)));
    }

    function testCamMintAndHaveBalance() public{
        vm.prank(USER);
        nft.mintNFT(URI);
        assert(nft.balanceOf(USER)==1);
        assert(keccak256(abi.encode(URI))==keccak256(abi.encode(nft.tokenURI(0))));
    }
}
