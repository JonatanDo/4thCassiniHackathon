pragma solidity >=0.5.0 <0.6.0;

import "./WaterHeroUpgrade.sol";

contract UpgradeHelper is WaterHeroUpgrade {

  uint levelUpFee = 0.001 ether;

  modifier aboveLevel(uint _level, uint _heroId) {
    require(heros[_heroId].level >= _level);
    _;
  }

  function withdraw() external onlyOwner {
    address payable _owner = address(uint160(owner()));
    _owner.transfer(address(this).balance);
  }

  function setLevelUpFee(uint _fee) external onlyOwner {
    levelUpFee = _fee;
  }

  function levelUp(uint _heroId) external payable {
    require(msg.value == levelUpFee);
    heroes[_heroId].level++;
  }

  function changeName(uint _heroId, string calldata _newName) external aboveLevel(2, _heroId) {
    require(msg.sender == heroToOwner[_heroId]);
    heroes[_heroId].name = _newName;
  }

  function changeLevel(uint _heroId, uint _newLevel) external aboveLevel(20, _heroId) {
    require(msg.sender == heroToOwner[_heroId]);
    heroes[_heroId].Level = _newLevel;
  }

  function getherosByOwner(address _owner) external view returns(uint[] memory) {
    uint[] memory result = new uint[](ownerheroCount[_owner]);
    uint counter = 0;
    for (uint i = 0; i < heros.length; i++) {
      if (heroToOwner[i] == _owner) {
        result[counter] = i;
        counter++;
      }
    }
    return result;
  }

}

