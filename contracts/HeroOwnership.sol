pragma solidity >=0.5.0 <0.6.0;

import "./WaterHeroUpgrade.sol";
import "./ERC721.sol";

contract HeroOwnership is HeroCleanup, ERC721 {

mapping (uint => address) heroApprovals;

  function balanceOf(address _owner) external view returns (uint256) {
    return ownerHeroCount[_owner];
  }

  function ownerOf(uint256 _tokenId) external view returns (address) {
    return HeroToOwner[_tokenId];
  }

  function _transfer(address _from, address _to, uint256 _tokenId) private {
    ownerHeroCount[_to]++;
    ownerHeroCount[_from]--;
    heroToOwner[_tokenId] = _to;
    emit Transfer(_from, _to, _tokenId);
  }

  function transferFrom(address _from, address _to, uint256 _tokenId) external payable {
    require (heroToOwner[_tokenId] == msg.sender || heroApprovals[_tokenId] == msg.sender);
    _transfer(_from, _to, _tokenId);
  }

  function approve(address _approved, uint256 _tokenId) external payable onlyOwnerOf(_tokenId) {
    heroApprovals[_tokenId] = _approved;
    emit Approval(msg.sender, _approved, _tokenId);
  }
}