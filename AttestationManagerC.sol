pragma solidity ^0.4.23;

import './Ownable.sol';
import './BasicToken.sol';

contract AttestationManagerC is Ownable, BasicToken {

    mapping (bytes32 => address) internal attestationEngine;

    constructor (address _owner) Ownable(_owner) public { }

    event AEadded(
        address indexed issuer,
        bytes32 indexed id,
        address AEaddress,
        uint updatedAt);
    event AEremoved(
        address indexed issuer,
        bytes32 indexed id,
        uint updatedAt);

    //add an attestation engine
    function addAE(bytes32 id, address AEaddress) public onlyOwner{
    	attestationEngine[id] = AEaddress;
    	emit AEadded(msg.sender, id, AEaddress, now);
    }

    //remove an attestation engine
    function removeAE(bytes32 id) public onlyOwner{
    	delete attestationEngine[id];
    	emit AEremoved(msg.sender, id, now);
    }

    function calculateBudget(){
        
    }
}
