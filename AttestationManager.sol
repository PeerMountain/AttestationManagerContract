pragma solidity ^0.4.23;

import './Ownable.sol';
import './BasicToken.sol';
import './ClaimsRegistry.sol';

contract AttestationManager is Ownable, BasicToken {

    mapping (bytes32 => address) public attestationEngine;
    mapping (bytes32 => mapping(bytes32 => uint256)) public tokenDebit;

        constructor (address _owner, uint256 _totalSupply) Ownable(_owner) BasicToken(_owner, _totalSupply) public { }

        event AEadded(
            address indexed issuer,
            bytes32 indexed AEid,
            address AEaddress,
            uint updatedAt);
        event AEremoved(
            address indexed issuer,
            bytes32 indexed AEid,
            uint updatedAt);

        //add an attestation engine
        function addAE(bytes32 AEid, address AEaddress) public onlyOwner{
            attestationEngine[AEid] = AEaddress;
            emit AEadded(msg.sender, AEid, AEaddress, now);
        }   

        //remove an attestation engine
        function removeAE(bytes32 AEid) public onlyOwner{
            delete attestationEngine[AEid];
            emit AEremoved(msg.sender, AEid, now);
        }

        function calculateBudget(bytes32 value) public returns (uint256){
            if(value.length != 0){
                return 1;
            }
            return 0;
        }
        function sendClaim(bytes32 value, uint256 tokens, bytes32 AEid, address addr){
            tokenDebit[AEid][keccak256(abi.encodePacked(value))] = tokens;
            ClaimsRegistry cr = ClaimsRegistry(addr);
            cr.setClaim(msg.sender, keccak256(abi.encodePacked(value)), value); 
        }
        function sendTokens(address AEaddress, bytes32 key){
            attestationEngine[AEid] = AEaddress;
            var AEid = attestationEngine[AEaddress]
            uint256 tokens = tokenDebit[AEid][key];
            bool sent = transfer(AEid, tokens);
            if(sent == true) delete tokenDebit[AEid][key] = tokens;
        }
    }
