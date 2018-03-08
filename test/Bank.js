var Bank = artifacts.require("./Bank.sol");

contract('Bank', () => {
  it('should have empty balance on cration', async () => {
    bank = await Bank.deployed();
    balance = await bank.balance();
    assert.equal(balance, 0, 'balance was not 0');
  });
});
