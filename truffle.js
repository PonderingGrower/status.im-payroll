module.exports = {
  // See <http://truffleframework.com/docs/advanced/configuration>
  // to customize your Truffle configuration!
  networks: {
    development: {
      /* using local testrcp instance */
      host: "localhost",
      port: 8545,
      network_id: "*"
    }
  }
};
