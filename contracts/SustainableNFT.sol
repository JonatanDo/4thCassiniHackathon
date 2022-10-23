pragma solidity >=0.5.0 <0.6.0;

import "./Ownable.sol";

contract SustainableNFT is Ownable {

    event NewHero(uint heroId, string name, uint level);

    uint levelDigits = 16;
    uint levelModulus = 10 ** levelDigits;
    uint cooldownTime = 1 days;

    struct Hero {
        string name;
        uint level;
        uint32 pollution;
        uint32 readyTime;
    }

    Hero[] public heroes;

    mapping (uint => address) public heroToOwner;
    mapping (address => uint) ownerHeroCount;

    function _createHero(string memory _name, uint _level) internal {
        uint id = heroes.push(Hero(_name, _level)) - 1;
        heroToOwner[id] = msg.sender;
        ownerHeroCount[msg.sender]++;
        emit NewHero(id, _name, _level);
    } 

}