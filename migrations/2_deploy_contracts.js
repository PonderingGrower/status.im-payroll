var Payroll = artifacts.require("./Payroll.sol");

module.exports = function(deployer) {
  deployer.deploy(Payroll, '0xdfc38c97ad26b3f679194b07a1d403be265b32bf');
};
