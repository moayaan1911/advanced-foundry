// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.18;

import {ERC721} from "../lib/openzeppelin-contracts/contracts/token/ERC721/ERC721.sol";
import {Base64} from "../lib/openzeppelin-contracts/contracts/utils/Base64.sol";

contract MoodNFT is ERC721 {
    error MoodNFT__CannotFlipIfNotOwnerOrNotApproved();

    uint256 private tokenId;
    string private sadSvgImageURI;
    string private happySvgImageURI;

    enum Mood {
        HAPPY,
        SAD
    }

    mapping(uint256 tokenId => Mood mood) private tokenIdToMood;

    constructor(string memory _sadSvgImageURI, string memory _happySvgImageURI) ERC721("MoodNFT", "MNFT") {
        sadSvgImageURI = _sadSvgImageURI;
        happySvgImageURI = _happySvgImageURI;
        tokenId = 0;
    }

    function mintNFT() public {
        _safeMint(msg.sender, tokenId);
        tokenIdToMood[tokenId] = Mood.HAPPY;
        tokenId++;
    }

    function flipMood(uint256 _tokenID) public {
        if (ownerOf(_tokenID) != msg.sender && getApproved(_tokenID) != msg.sender) { // checks using inbuild openzeppelin contract if the sender is owner or approved
            revert MoodNFT__CannotFlipIfNotOwnerOrNotApproved();
        }
        if (tokenIdToMood[_tokenID] == Mood.HAPPY) {
            tokenIdToMood[_tokenID] = Mood.SAD;
        } else {
            tokenIdToMood[_tokenID] = Mood.HAPPY;
        }
    }

    function _baseURI() internal pure override returns (string memory) {
        return "data:application/json;base64,";
    }

    function tokenURI(uint256 _tokenId) public view virtual override returns (string memory) {
        string memory imageURI;
        if (tokenIdToMood[_tokenId] == Mood.HAPPY) {
            imageURI = happySvgImageURI;
        } else {
            imageURI = sadSvgImageURI;
        }
        return string(
            abi.encodePacked(
                _baseURI(),
                Base64.encode(
                    bytes( // bytes casting actually unnecessary as 'abi.encodePacked()' returns a bytes
                        abi.encodePacked(
                            '{"name":"',
                            name(), // You can add whatever name here
                            '", "description":"An NFT that reflects the mood of the owner, 100% on Chain!", ',
                            '"attributes": [{"trait_type": "moodiness", "value": 100}], "image":"',
                            imageURI,
                            '"}'
                        )
                    )
                )
            )
        );
    }
}
