pragma solidity ^0.4.23;

contract Ownable {

    address owner;

    modifier onlyOwner(){
        require(msg.sender == owner);
        _;
    }
    constructor(address _owner) public {
        owner = _owner;
    }
}
