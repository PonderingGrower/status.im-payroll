const assertThrowsAsync = require('./assertThrows.js')
const Payroll = artifacts.require('./Payroll.sol')

contract('Payroll', () => {
  it('should have no employees after deployment', async () => {
    meta = await Payroll.deployed()
    count = await meta.getEmployeeCount()
    assert.equal(count, 0, 'incorrect number of employees')
  })

  it('should add a new employee', async () => {
    meta = await Payroll.deployed()
    await meta.addEmployee(web3.eth.accounts[1], [], 100)
    count = await meta.getEmployeeCount()
    assert.equal(count.toNumber(), 1, 'employee was not added')
  })

  it('should return new employee address', async () => {
    meta = await Payroll.deployed()
    addr = await meta.getEmployee(web3.eth.accounts[1])
    assert.notEqual(addr, undefined, 'employee id was not returned')
  })

  it('should remove employee', async () => {
    meta = await Payroll.deployed()
    id = await meta.getAccountEmployee(web3.eth.accounts[1])
    addr = await meta.getEmployee(0)
    await meta.removeEmployee(id.toNumber())
    count = await meta.getEmployeeCount()
    assert.equal(count.toNumber(), 0, 'employee was not removed')
  })

  //it('should remove employee', async () => {
  //  meta = await Payroll.deployed()
  //  await assertThrowsAsync(
  //    async () => { await meta.withdraw(500) },
  //    /VM Exception while processing transaction: revert/
  //  )
  //  assert.equal(balance, 300, 'balance was unchanged')
  //})
})
