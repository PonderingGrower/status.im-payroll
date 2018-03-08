pragma solidity ^0.4.19;

contract Bank {
    uint public balance;

    function Bank() public {
        balance = 0;
    }

    function deposit(uint _value) public payable returns (uint _balance) {
        balance += _value;
        return balance;
    }

    function withdraw(uint _value) public payable returns (uint _balance) {
        if (balance < _value) { return; }
        balance -= _value;
        return balance;
    }
}
