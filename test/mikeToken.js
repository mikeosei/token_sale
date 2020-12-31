var mikeToken = artifacts.require("./mikeToken.sol");

//initialize test suite
//callback function will pass back all accounts available to ganache
contract('mikeToken', function(accounts){
    it('sets the total supply upon deployment', function() {

        return mikeToken.deployed().then(instance =>{
            return instance.totalSupply()
        }).then (totalSupply =>{
            assert.equal(totalSupply.toNumber(), 10990000,'sets the total suply ot 1,000,000')
        })
    });
})