const mikeToken = artifacts.require("./mikeToken.sol");

module.exports = function (deployer) {
  deployer.deploy(mikeToken);
};
