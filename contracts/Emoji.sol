// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract Emoji is ERC721URIStorage {
  using Counters for Counters.Counter;
  Counters.Counter private _tokenIds;
  
  struct NFTData {
    uint256 tokenId;
    string stringData;
    address targetAddress;
    int256 x;
    int256 y;
  }

  mapping (uint256 => NFTData) private _nftData;
  mapping (int256 => mapping(int256 => uint256)) private _coordinatesToTokenId;

  constructor() ERC721("Emoji", "EMOJI") {}

  function mint(address recipient, string memory tokenURI, string memory stringData, address targetAddress, int256 x, int256 y) public returns (NFTData memory nftData) {
    require(_coordinatesToTokenId[x][y] == 0, "This coordinate is already taken");

    _tokenIds.increment();
    uint256 tokenId = _tokenIds.current();
    _mint(recipient, tokenId);
    _setTokenURI(tokenId, tokenURI);

    nftData = NFTData(tokenId, stringData, targetAddress, x, y);
    _nftData[tokenId] = nftData;
    _coordinatesToTokenId[x][y] = tokenId;
  }

  function getNFTById(uint256 tokenId) public view returns (NFTData memory) {
    require(_exists(tokenId), "Token does not exist");

    return _nftData[tokenId];
  }

  function getNFTByCoordinates(int256 x, int256 y) public view returns (NFTData memory) {
    uint256 tokenId = _coordinatesToTokenId[x][y];
    if (tokenId == 0) {
      return NFTData(0, "", address(0), 0, 0);
    }

    return _nftData[tokenId];
  }

  function getNFTsInRectangle(int256 x1, int256 y1, int256 x2, int256 y2) public view returns (NFTData[][] memory) {
    require(x2 >= x1 && y2 >= y1, "Invalid range");

    uint256 rowCount = uint256(y2 - y1 + 1);
    uint256 colCount = uint256(x2 - x1 + 1);
    uint256 area = rowCount * colCount;
    require(area <= 500, "Rectangle area exceeds 500");

    NFTData[][] memory nftDataArr = new NFTData[][](rowCount);
    for (uint256 i = 0; i < rowCount; i++) {
      nftDataArr[i] = new NFTData[](colCount);
      int256 y = int256(i) + y1;
      for (uint256 j = 0; j < colCount; j++) {
        int256 x = int256(j) + x1;
        nftDataArr[i][j] = getNFTByCoordinates(x, y);
      }
    }

    return nftDataArr;
  }
}
