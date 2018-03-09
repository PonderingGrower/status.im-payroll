const assertThrowsAsync = require('./assertThrows.js')
const Payroll = artifacts.require('./Payroll.sol')

contract('Payroll', () => {
  it('should have no employees after deployment', async () => {
    let meta = await Payroll.deployed()
    let count = await meta.getEmployeeCount()
    assert.equal(count, 0, 'incorrect number of employees')
  })

  it('should add a new employee', async () => {
    let meta = await Payroll.deployed()
    await meta.addEmployee(web3.eth.accounts[1], [], 100)
    let count = await meta.getEmployeeCount()
    assert.equal(count.toNumber(), 1, 'employee was not added')
  })

  it('should return new employee address', async () => {
    let meta = await Payroll.deployed()
    let addr = await meta.getEmployee(web3.eth.accounts[1])
    assert.notEqual(addr, undefined, 'employee id was not returned')
  })

  it('should change employee salary', async () => {
    let meta = await Payroll.deployed()
    let id = await meta.getAccountEmployee(web3.eth.accounts[1])
    await meta.setEmployeeSalary(id.toNumber(), 500)
    let salary = await meta.getEmployeeSalary(id.toNumber())
    assert.equal(salary.toNumber(), 500, 'employee salary was not changed')
  })

  it('should remove employee', async () => {
    let meta = await Payroll.deployed()
    let id = await meta.getAccountEmployee(web3.eth.accounts[1])
    let addr = await meta.getEmployee(0)
    await meta.removeEmployee(id.toNumber())
    let count = await meta.getEmployeeCount()
    assert.equal(count.toNumber(), 0, 'employee was not removed')
  })

  it('should fail when changing missing employee', async () => {
    let meta = await Payroll.deployed()
    await assertThrowsAsync(
      async () => { await meta.setEmployeeSalary(3, 1000) },
      /VM Exception while processing transaction: revert/
    )
  })

  it('should return all funds when escapeHatch is called', async () => {
    let meta = await Payroll.deployed()
    let tx = {
      from: web3.eth.accounts[0],
      to: meta.contract.address,
      value: web3.toWei(1, 'ether'),
      data: '',
      gas: 50000,
    }
    let txHash = await meta.addFunds.sendTransaction(tx)
    assert.notEqual(txHash, undefined, 'transaction was not successful')
    let balance = web3.eth.getBalance(meta.contract.address).toNumber()
    assert.equal(web3.fromWei(balance, 'ether'), 1, 'contract did not receive funds')
    await meta.escapeHatch()
    balance = web3.eth.getBalance(meta.contract.address).toNumber()
    assert.equal(balance, 0, 'contract did not return funds')
  })

})
