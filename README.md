# Description

Solution to a recruitment task for Statis.im.

# Task

https://wiki.status.im/Hiring_Process#DevOps_Inclusion_Activity

Write the code (deployable to the EVM), publish it on GitHub (public or private) and send the link to the repo. Please include any additional information you consider important.

The code we are looking for could be conformant to the following interface. Feel free to remove/add any functions as you see fit:

```solidity
// For the sake of simplicity lets assume EUR is a ERC20 token
// Also lets assume we can 100% trust the exchange rate oracle
contract PayrollInterface {
    /* OWNER ONLY */
    function addEmployee(address accountAddress, address[] allowedTokens, uint256 initialYearlyEURSalary);
    function setEmployeeSalary(uint256 employeeId, uint256 yearlyEURSalary);
    function removeEmployee(uint256 employeeId);

    function addFunds() payable;
    function scapeHatch();
    // function addTokenFunds()? // Use approveAndCall or ERC223 tokenFallback

    function getEmployeeCount() constant returns (uint256);
    function getEmployee(uint256 employeeId) constant returns (address employee); // Return all important info too

    function calculatePayrollBurnrate() constant returns (uint256); // Monthly EUR amount spent in salaries
    function calculatePayrollRunway() constant returns (uint256); // Days until the contract can run out of funds

    /* EMPLOYEE ONLY */
    function determineAllocation(address[] tokens, uint256[] distribution); // only callable once every 6 months
    function payday(); // only callable once a month

    /* ORACLE ONLY */
    function setExchangeRate(address token, uint256 EURExchangeRate); // uses decimals from token
}
```

# Links

* Ethereum
  * https://ethereum.org/cli
  * https://www.ethereum.org/greeter
  * https://github.com/ethereum/wiki/wiki/White-Paper
* ERC-223 Token
  * https://github.com/ethereum/EIPs/issues/223
  * https://github.com/Dexaran/ERC223-token-standard
  * https://github.com/Dexaran/ERC223-token-standard/tree/Recommended#erc23-token-standard
* Web3
  * https://github.com/ethereum/web3.js/
  * https://github.com/ethereum/web3.js/blob/master/example/contract.html
* Geth
  * https://github.com/ethereum/wiki/wiki/Ethereum-Development-Tutorial
  * https://github.com/ethereum/go-ethereum/wiki
  * https://github.com/ethereum/go-ethereum/wiki/Contract-Tutorial
* Sodility
  * https://github.com/tomlion/vim-solidity
  * https://solidity.readthedocs.io/en/develop/using-the-compiler.html
  * https://solidity.readthedocs.io/en/latest/solidity-by-example.html
  * https://solidity.readthedocs.io/en/latest/solidity-in-depth.html
* Web Editor
  * https://remix.ethereum.org/#optimize=false&version=soljson-v0.4.21+commit.dfe3193c.js
* Tools
  * http://truffleframework.com/docs/
  * http://truffleframework.com/docs/getting_started/project
  * http://truffleframework.com/docs/advanced/configuration
  * https://github.com/OpenZeppelin/zeppelin-solidity
  * https://github.com/carsenk/explorer
* Video
  * https://www.youtube.com/watch?v=8jI1TuEaTro
  * https://www.youtube.com/watch?v=rktHO5R8Y9c
