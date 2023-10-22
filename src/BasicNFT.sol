// SPDX-License-Identifier: MIT 
pragma solidity ^0.8.0;

import {ERC721} from "lib/openzeppelin-contracts/contracts/token/ERC721/ERC721.sol";

contract BasicNFT is ERC721{
    uint256 s_TokenCounter=0;
    mapping(uint256=>string) private s_TokenIDtoURI;

    constructor()ERC721("Doggie","Dog"){
        s_TokenCounter=0;
    }
    function mintNFT(string memory TokenURI) public{
        s_TokenIDtoURI[s_TokenCounter]=TokenURI;
        _safeMint(msg.sender,s_TokenCounter);
        s_TokenCounter++;
    }
    function tokenURI(uint256 TokenID) public view override returns(string memory){
        return s_TokenIDtoURI[TokenID];
    }
}