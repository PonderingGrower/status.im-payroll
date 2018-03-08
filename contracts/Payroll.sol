pragma solidity ^0.4.19;

import './PayrollInterface.sol';

/* specification said nothing about contract being killable */
contract Payroll is PayrollInterface {
    struct Employee {
        uint256 id;
        address addr;
        address[] allowedTokens;
        uint256 yearlyEURSalary;
        uint256 initialYearlyEURSalary;
    }

    mapping(uint256 => Employee) public employees;
    mapping(address => uint256) public employeeIDs;
    
    uint256 public idsCounter;
    /* mappings don't store length */
    uint256 public employees_count;

    /* which account is allowed to manage this payroll */
    address owner;
    /* can set exchange rate values */
    address oracle;
    
    /* MODIFIERS */
    modifier isOwner() { require(msg.sender == owner); _; }
    modifier isOracle() { require(msg.sender == oracle); _; }
    modifier employeeIdExists(uint256 _id) { require(employees[_id].addr != address(0)); _; }
    modifier employeeAddrMissing(address _addr) { require(employeeIDs[_addr] == 0); _; }
    modifier isEmployee(address _addr) { require(employeeIDs[_addr] != 0); _; }
    modifier senderIsEmployee() { require(employeeIDs[msg.sender] != 0); _; }

    function Payroll() public {
        /* we the owner is whoever deployed this contract */
        owner = msg.sender;
    }

    /* OWNER ONLY */
    function addEmployee(address _addr, address[] _allowedTokens, uint256 _initialYearlyEURSalary) public
        isOwner employeeAddrMissing(_addr)
    {
        employees[idsCounter++] = Employee({
            id: idsCounter++,
            addr: _addr,
            allowedTokens: _allowedTokens,
            yearlyEURSalary: 0,
            initialYearlyEURSalary: _initialYearlyEURSalary
        });
        employeeIDs[_addr] = idsCounter;
        employees_count++;
    }

    function setEmployeeSalary(uint256 _employeeId, uint256 _yearlyEURSalary) public
        isOwner employeeIdExists(_employeeId)
    {
        employees[_employeeId].yearlyEURSalary = _yearlyEURSalary;
    }

    function removeEmployee(uint256 _employeeId) public
        isOwner employeeIdExists(_employeeId)
    {
        delete employees[_employeeId];
        employees_count--;
    }

    function getEmployeeCount() public constant
        isOwner returns (uint256)
    {
        return employees_count;
    }

    function getEmployee(uint256 _employeeId) public constant
        returns (address)
    {
        return employees[_employeeId].addr;
    }

    function setOracle(address _oracle) public
        isOwner
    {
        oracle = _oracle;
    }

    /* FUNDS */
    /* I have absolutely no idea what this function is supposed to be */
    //function scapeHatch() public;

    function addFunds() payable public isOwner() {}

    ///* Use approveAndCall or ERC223 tokenFallback */
    /* As far as I can tell ERC223 is still not complete
     * since this issue is still open:
     * https://github.com/ethereum/EIPs/issues/223
     */
    //function addTokenFunds() payable public;

    /* This doesn't seem like something that should be run within EVM... */
    //function calculatePayrollBurnrate() public constant returns (uint256); // Monthly EUR amount spent in salaries
    //function calculatePayrollRunway() public constant returns (uint256); // Days until the contract can run out of funds

    /* EMPLOYEE ONLY */
    //function determineAllocation(address[] tokens, uint256[] distribution); // only callable once every 6 months
    //function payday(); // only callable once a month

    /* ORACLE ONLY */
    function setExchangeRate(address _token, uint256 _EURExchangeRate) public
        isOracle
    {
        /* TODO */
    }
}