// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract OdysseyNFTs is ERC721 {
    uint256 public tokenId;
    mapping(uint256 => string) public uris;

    constructor() ERC721("OdysseyNFTs", "ACOdyssey") {}

    event MetadataChanged(
        uint256 _tokenId,
        string oldURI,
        string newURI,
        address indexed owner
    );

    function mint(string memory uri) external {
        require(tokenId < 3000, "MAX_NFT_LIMIT");
        uint256 newTokenid = ++tokenId;
        uris[newTokenid] = uri;
        _safeMint(msg.sender, newTokenid);
    }

    function tokenURI(uint256 _tokenId)
        public
        view
        override
        returns (string memory)
    {
        return uris[_tokenId];
    }

    function setTokenURI(uint256 _tokenId, string memory newURI) external {
        address tokenOwner = ownerOf(_tokenId);
        require(_msgSender() == tokenOwner, "ONLY_OWNER");

        emit MetadataChanged(_tokenId, uris[_tokenId], newURI, tokenOwner);

        uris[_tokenId] = newURI;
    }
}
