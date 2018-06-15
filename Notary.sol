pragma solidity ^0.4.23;

import './Ownable.sol';

contract Notary is Ownable{

	uint id;
	mapping (bytes32 => MessageData) public messages;

	event MessageSaved(bytes32 messageHash);

	constructor(uint _id) public {
		id = _id;
	}

	struct MessageData {
		bytes32 messageHash;
		bytes32 messageSender;
		uint64 timestamp;
	}

function saveMessage(bytes32 messageHash, bytes32 messageSender, uint64 timestamp) public onlyOwner {
		messages[messageHash]=MessageData(messageHash, messageSender,timestamp);
		emit MessageSaved(messageHash);
	}

 }
