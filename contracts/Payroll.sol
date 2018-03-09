pragma solidity ^0.4.19;

import './Owned.sol';
import './PayrollInterface.sol';

/* specification said nothing about contract being killable */
contract Payroll is PayrollInterface, Owned {
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

    /* can set exchange rate values */
    address oracle;
    
    /* MODIFIERS */
    modifier isOracle() { require(msg.sender == oracle); _; }
    modifier employeeIdExists(uint256 _id) { require(employees[_id].addr != address(0)); _; }
    modifier employeeAddrMissing(address _addr) { require(employeeIDs[_addr] == 0); _; }
    modifier isEmployee(address _addr) { require(employeeIDs[_addr] != 0); _; }
    modifier senderIsEmployee() { require(employeeIDs[msg.sender] != 0); _; }

    function Payroll() public {
    }

    /* OWNER ONLY */
    function addEmployee(address _addr, address[] _allowedTokens, uint256 _initialYearlyEURSalary) public
        isOwner employeeAddrMissing(_addr) returns (uint256)
    {
        /* increment first so we start from 1, not 0 */
        idsCounter++;
        Employee memory employee = Employee({
            id: idsCounter,
            addr: _addr,
            allowedTokens: _allowedTokens,
            yearlyEURSalary: 0,
            initialYearlyEURSalary: _initialYearlyEURSalary
        });
        employees[employee.id] = employee;
        employeeIDs[_addr] = idsCounter;
        employees_count++;
        return idsCounter;
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

    function getAccountEmployee(address _addr) public constant
        isOwner returns (uint256)
    {
        return employeeIDs[_addr];
    }

    function getEmployee(uint256 _employeeId) public constant
        isOwner returns (address)
    {
        return employees[_employeeId].addr;
    }

    function getEmployeeSalary(uint256 _employeeId) public constant
        isOwner returns (uint256)
    {
        return employees[_employeeId].yearlyEURSalary;
    }

    function setOracle(address _oracle) public
        isOwner
    {
        oracle = _oracle;
    }

    /* FUNDS */
    function escapeHatch() public
        isOwner
    {
        /* way to recover any funds sent to this contract */
        selfdestruct(owner);
    }

    /* WARN: necessary to be able to add funds to a contract */
    function addFunds() payable public isOwner {}

    /* Use approveAndCall or ERC223 tokenFallback */
    /**
     * As far as I can tell ERC223 is still not complete/accepted
     * since this issue is still open, but I might be wrong:
     * https://github.com/ethereum/EIPs/issues/223
     *
     * Also I'm not sure what you want me to do here.
     * Is the Payroll contract supposed to inherit from ERC223 and run
     * it's own type of tokens? I think I'd need to talk to someone
     * well versed in smart contract so I can ask some questions because
     * I'm still a bit unsure of some details.
     **/
    //function addTokenFunds() payable public;

    /* Reporting doesn't seem like something that should be run within EVM... */
    //function calculatePayrollBurnrate() public constant returns (uint256); // Monthly EUR amount spent in salaries
    //function calculatePayrollRunway() public constant returns (uint256); // Days until the contract can run out of funds

    /* EMPLOYEE ONLY */
    //function determineAllocation(address[] tokens, uint256[] distribution); // only callable once every 6 months
    //function payday(); // only callable once a month

    /* ORACLE ONLY */
    function setExchangeRate(address _token, uint256 _EURExchangeRate) public
        isOracle
    {
        /** TODO
         * Not really sure what I'm supposed to do here.
         * That's probably because I don't really fully get how the
         * tokens work in Ethereum contracts. The way I undestand it
         * a contract can have it's own ledger of some kind of tokens,
         * usually implemented using ERC20 or ERC223.
         * But the addTokenFunds() method confuses me because it seems
         * like it implies I could receive tokens from another contract
         * into this contract, which seems weird, since I wouldn't need
         * to keep track of that, that's the job of the contract that
         * defines the specific token.
         * Unless you wanted me to make this Payroll contract to also have
         * it's own tokens for internal management of salaries.
         * If that is the case than that's a bit above my understanding
         * of smart contract for now.
         **/
    }
}
