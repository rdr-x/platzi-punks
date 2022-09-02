// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
// import "@openzeppelin/contracts/access/Ownable/.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/utils/Base64.sol";
import "./PlatziPunksDNA.sol";

contract PlatziPunks is ERC721, ERC721Enumerable, PlatziPunksDNA {
  uint256 public maxSupply;
  
  using Counters for Counters.Counter;
  Counters.Counter private _idCounter;

  constructor(uint256 _maxSupply) ERC721("PlatziPunks","PLZPK") {
      maxSupply = _maxSupply;
    }
  
  function mint() public {
      uint256 current = _idCounter.current();
      require(current<maxSupply, "No platziPunks left");
      _safeMint(msg.sender, current);
      _idCounter.increment();
    }

  function tokenURI(uint256 tokenId) public view override returns (string memory) {
    require(
    _exists(tokenId),
    "ERC721 Metadata: URI query for nonexistent token"
    );
    
    string memory jsonURI = Base64.encode(
    abi.encodePacked(
      '{ "name": "PlatziPunks #',
          tokenId,
          '"external_url": "ipfs://<hash>"',
          '", "description": "Platzi Punks are randomized Avataaars stored on chain to teach DApp development on Platzi", "image": "',
          "// TODO: Calculate image URL",
          '"attributes": [{"Accessories Type": "Blank" ,"Clothe Color": "Red","Clothe Type":"Hoodie","Eye Type":"Close","Eye Brow Type":"Angry","Facial Hair Color":"Blonde","Facial Hair Type":"MoustacheMagnum","Hair Color":"SilverGray","Hat Color":"white","Graphic Type":"Skull","Mouth Type":"Smile","Skin Color":"Light","Top Type":"LongHairMiaWallace",}]',
          '"}'
          )
    );

    return string(abi.encode("data:application/json;base64", jsonURI));

  }

  function _beforeTokenTransfer(address from, address to, uint256 tokenId)
        internal
        override(ERC721, ERC721Enumerable)
    {
        super._beforeTokenTransfer(from, to, tokenId);
    }

    function supportsInterface(bytes4 interfaceId)
        public
        view
        override(ERC721, ERC721Enumerable)
        returns (bool)
    {
        return super.supportsInterface(interfaceId);
    }
}
