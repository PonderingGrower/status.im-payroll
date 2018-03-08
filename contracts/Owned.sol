pragma solidity ^0.4.19;

contract Owned {
    address owner;

    modifier isOwner() { require(msg.sender == owner); _; }

    function Owned() public {
        owner = msg.sender;
    }
    function transferOwnership(address _newOwner) public
        isOwner
    {
        owner = _newOwner;
    }
}
