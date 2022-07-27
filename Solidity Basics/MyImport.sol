// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC721/ERC721.sol";

contract NFT {
    uint256 dna;
    string name;

    constructor(string memory _name, uint256 _dna) {
        name = _name;
        dna = _dna;
    }
}

contract MyImport is ERC721 {
    NFT[] public nfts;
    bytes32 myBytesName = "Cesar";

    constructor(string memory _name, string memory _symbol) ERC721(_name, _symbol) {}

    function addNFT(string memory _name, uint256 _dna) public {
        NFT nft = new NFT(_name, _dna);
        nfts.push(nft);
    }

    function myHashedName(string memory _name) public pure returns (bytes32) {
        return keccak256(abi.encodePacked(_name));
    }
}