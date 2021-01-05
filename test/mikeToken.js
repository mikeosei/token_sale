var mikeToken = artifacts.require("./mikeToken.sol");

//initialize test suite
//callback function will pass back all accounts available to ganache
contract('mikeToken', function(accounts){
    var tokenInstance;
    it('Intializes the contract with correct values',() => {
        return mikeToken.deployed().then(instance =>{
            tokenInstance = instance
            return tokenInstance.name()
        }).then (name =>{
            assert.equal(name, 'Mike Token','check token name')
            return tokenInstance.symbol()
        }).then(symbol => {
            assert.equal(symbol,'MIKE','check token symbol')
            return tokenInstance.standard();
        }).then(standard => {
            assert.equal(standard,'Mike Token v1.0','check token standard')
        }

        )
    })
    it('Allocates the initial supply upon deployment', function() {

        return mikeToken.deployed().then(instance =>{
            tokenInstance = instance
            return tokenInstance.totalSupply()
        }).then (totalSupply =>{
            assert.equal(totalSupply.toNumber(), 1000000,'sets the total supply of 1,000,000')
            return tokenInstance.balanceOf(accounts[0])
        }).then(adminBalance => {
            assert.equal(adminBalance.toNumber(), 1000000, 'it allocates the initial supupply to admin account ')
        })
    });

    it ('transfers token ownership', () => {
        return mikeToken.deployed().then(instance => {
            tokenInstance = instance;
            //should raise a error because the transfer amount far exceeds any possible balance of an given EOA
            //Note - .call allows us to call our function and inspect but does not create a transaction, so there will be no receipt
            return tokenInstance.transfer.call(accounts[1],23939239293393)
        }).then(assert.fail).catch(error =>{
            assert(error.message.indexOf('revert') >= 0, 'error must contain substring revert, if revert will be at an index greater than 0')
            //Note - .call allows us to call our function and inspect but does not create a transaction, so there will be no receipt
            return tokenInstance.transfer.call(accounts[1], 250000, {from:accounts[0]});
        }).then(success => {
            assert.equal(success, true, 'it returns true')
            //Calls the transfer function naturally and return a receipt
            return tokenInstance.transfer(accounts[1], 250000)
        }).then(receipt =>{
            assert.equal(receipt.logs.length, 1, 'since there is only one event, the transaction reciept should be length 1')
            assert.equal(receipt.logs[0].event, 'Transfer', 'should be the "Transfer" event')
            assert.equal(receipt.logs[0].args._from, accounts[0], 'logs the account the tokens are transferred from')
            assert.equal(receipt.logs[0].args._to, accounts[1], 'logs the account the tokens are transferred to')
            assert.equal(receipt.logs[0].args._value, 250000, 'logs the transfer amount')
            return tokenInstance.balanceOf(accounts[1])
        }).then(balance => {
            assert.equal(balance.toNumber(), 250000, 'adds the amount to the receiving account')
            return tokenInstance.balanceOf(accounts[0])
        }).then(balance => {
            assert.equal(balance.toNumber(), 750000, 'deducts the amount from the sending account')
        })
    })
})