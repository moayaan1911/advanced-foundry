// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity 0.8.21;

import {ERC721} from "../lib/openzeppelin-contracts/contracts/token/ERC721/ERC721.sol";
import {Base64} from "../lib/openzeppelin-contracts/contracts/utils/Base64.sol";

contract MoodNFT is ERC721 {
    uint256 private tokenId;
    string private sadSvgImageURI;
    string private happySvgImageURI;

    constructor(
        string memory _sadSvgImageURI,
        string memory _happySvgImageURI
    ) ERC721("MoodNFT", "MNFT") {
        sadSvgImageURI = _sadSvgImageURI;
        happySvgImageURI = _happySvgImageURI;
        tokenId = 0;
    }

    enum Mood {
        HAPPY, SAD
    };

    mapping (uint256 tokenId => Mood mood) tokenIdToMood;

    function mintNFT() public {}

    function tokenURI(
        uint256 tokenId
    ) public view virtual override returns (string memory) {
        return
            string(
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
