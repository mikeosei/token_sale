const mikeToken = artifacts.require("./mikeToken.sol");

module.exports = function (deployer) {

    // pass in 1000000 as initial token amount 
  deployer.deploy(mikeToken, 1000000);
};
