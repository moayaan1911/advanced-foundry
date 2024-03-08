// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity 0.8.21;

import "../lib/openzeppelin-contracts/contracts/token/ERC721/ERC721.sol";

contract BasicNFT is ERC721 {
    uint256 private tokenCounter;

    mapping(uint256 => string) tokenIdToTokenURI; // token Counter to token URI

    constructor() ERC721("Dogie", "DOG") {
        tokenCounter = 0;
    }

    function mintNft(string memory _tokenURI) public {
        tokenIdToTokenURI[tokenCounter] = _tokenURI;
        _safeMint(msg.sender, tokenCounter);
        tokenCounter++;
    }

    function tokenURI(
        uint256 _tokenId
    ) public view override returns (string memory) {
        return tokenIdToTokenURI[_tokenId];
    }
}
