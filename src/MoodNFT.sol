// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {ERC721} from "lib/openzeppelin-contracts/contracts/token/ERC721/ERC721.sol";
import {Base64} from "lib/openzeppelin-contracts/contracts/utils/Base64.sol";

contract MoodNFT is ERC721 {
    error MoodNFT__CantRevert();
    uint256 s_TokenCounter = 0;
    string s_HappyURI;
    string s_SadURI;

    enum Mood {
        Happy,
        Sad
    }

    mapping(uint256 => Mood) s_TokenIDtoMood;

    constructor(
        string memory HappyURI,
        string memory SadURI
    ) ERC721("Mood", "MN") {
        s_TokenCounter = 0;
        s_HappyURI = HappyURI;
        s_SadURI = SadURI;
    }

    function _baseURI() internal pure override returns (string memory) {
        return "data:application/json;base64,";
    }

    function isApprovedOrOwner(
        address spender,
        uint256 tokenId
    ) public view returns (bool) {
        address owner = ownerOf(tokenId);
        address approved = getApproved(tokenId);

        return (spender == owner || spender == approved);
    }

    function flipMood(uint256 tokenId) public {
        if (!isApprovedOrOwner(msg.sender, tokenId)) {
            revert MoodNFT__CantRevert();
        }

        if (s_TokenIDtoMood[tokenId] == Mood.Happy) {
            s_TokenIDtoMood[tokenId] = Mood.Sad;
        } else {
            s_TokenIDtoMood[tokenId] = Mood.Happy;
        }
    }

    function mintNFT() public {
        _safeMint(msg.sender, s_TokenCounter);
        s_TokenIDtoMood[s_TokenCounter] = Mood.Sad;
        s_TokenCounter++;
    }

    function tokenURI(
        uint256 tokenID
    ) public view override returns (string memory) {
        string memory imageURI;
        if (s_TokenIDtoMood[tokenID] == Mood.Happy) {
            imageURI = s_HappyURI;
        } else {
            imageURI = s_SadURI;
        }
        return
            string(
                abi.encodePacked(
                    _baseURI(),
                    Base64.encode(
                        bytes(
                            abi.encodePacked(
                                '{"name":"',
                                name(),
                                '", "description":"A NFT that reflects mood of the owner","image":"',
                                imageURI,
                                '"}'
                            )
                        )
                    )
                )
            );
    }

    function getTokenCounter() external view returns (uint256) {
        return s_TokenCounter;
    }
}
