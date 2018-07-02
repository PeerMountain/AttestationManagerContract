pragma solidity ^0.4.23;

import './Ownable.sol';

contract Whitelisted is Ownable {

    constructor(address _owner) Ownable(_owner) public {
        addToWhitelist(_owner);
    }

    mapping(address => bool) internal whitelistedAddresses;

    function isWhitelisted(address addr) internal view returns (bool) {
        return whitelistedAddresses[addr];
    }

    function addToWhitelist(address addr) public onlyOwner {
        require(!isWhitelisted(addr));
        whitelistedAddresses[addr] = true;
    }

    function removeFromWhitelist(address addr) public onlyOwner {
        require(isWhitelisted(addr));
        whitelistedAddresses[addr] = false;
    }

    modifier onlyWhitelisted {
        if(!isWhitelisted(msg.sender))
          revert("msg.sender is not allowed to call that function");
        _;
    }
}
