pragma solidity ^0.4.19;

// For the sake of simplicity lets assume EUR is a ERC20 token
// Also lets assume we can 100% trust the exchange rate oracle
contract PayrollInterface {
    /* OWNER ONLY */
    function addEmployee(address _accountAddress, address[] _allowedTokens, uint256 _initialYearlyEURSalary) public;
    function setEmployeeSalary(uint256 _employeeId, uint256 _yearlyEURSalary) public;
    function removeEmployee(uint256 _employeeId) public;

    function getEmployeeCount() public constant returns (uint256);
    function getEmployee(uint256 _employeeId) public constant returns (address employee); // Return all important info too

    //function addFunds() payable public;
    //function scapeHatch() public;
    //function addTokenFunds()? // Use approveAndCall or ERC223 tokenFallback

    //function calculatePayrollBurnrate() public constant returns (uint256); // Monthly EUR amount spent in salaries
    //function calculatePayrollRunway() public constant returns (uint256); // Days until the contract can run out of funds

    /* EMPLOYEE ONLY */
    //function determineAllocation(address[] tokens, uint256[] distribution) public; // only callable once every 6 months
    //function payday() public; // only callable once a month

    /* ORACLE ONLY */
    function setExchangeRate(address _token, uint256 _EURExchangeRate) public; // uses decimals from token
}
