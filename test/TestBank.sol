pragma solidity ^0.4.2;

import 'truffle/Assert.sol';
import 'truffle/DeployedAddresses.sol';
import '../contracts/Bank.sol';

contract TestBank {

  function testInitialBalanceUsingDeployedContract() public {
    Bank meta = Bank(DeployedAddresses.Bank());

    Assert.equal(
      meta.balance(), 0,
      'Owner should have 10000 Bank initially'
    );
  }
}
