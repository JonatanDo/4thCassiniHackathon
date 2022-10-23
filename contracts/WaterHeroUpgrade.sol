pragma solidity >=0.5.0 <0.6.0;

import "./SustainableNFT.sol";

contract SustainableNFTPromotors {
  function getPromotor(uint256 _id) external view returns (
    bool isOpen,
    bool isReady,
    bool isClosed,
    bool isDead,

    uint256 PromotorAddress
  );
}

contract WaterHeroUpgrade is SustainableNFT {

  SustainableNFTPromotors promotorContract;

  function setPromotorContractAddress(address _address) external onlyOwner {
    promotorContract = SustainableNFTPromotors(_address);
  }
  
  ///address ckAddress = 0x07F5c63d62095eA72A9d13257B7e7351948dbe58; ///Jonatan_address_Avalanche_Fuji_Tesnet_Hackathon_BBVA_2022
  ///SustainableNFTPromotors promotorContract = SustainableNFTPromotors(ckAddress);


  function _triggerCooldown(Hero storage _hero) internal {
    _hero.readyTime = uint32(now + cooldownTime);
  }

  function _isReady(Hero storage _hero) internal view returns (bool) {
      return (_hero.readyTime <= now);
  }

  function upgrade(uint _heroId, uint _targetLevel, string memory _species) internal {
    require(msg.sender == heroToOwner[_heroId]);
    Hero storage myHero = heroes[_heroId];
    require(_isReady(myHero));
    _targetLevel = _targetLevel % levelModulus;
    uint newLevel = (myHero.level + _targetLevel) / 2;
    _createHero("NoName", newLevel);
  }

}