pragma solidity ^0.5.16;

contract mikeToken {
    //declaring state variable public will implicitly create a getter for totalSupply
    uint256 public totalSupply;

    string public name = "Mike Token";

    string public symbol = "MIKE";

    string public standard = "Mike Token v1.0";

    //key:value mapping
    mapping(address => uint256) public balanceOf;

    event Transfer(address indexed _from, address indexed _to, uint256 _value);

    constructor(uint256 _initialSupply) public {
        //sends 1000000 mikeToken to the EOA that uploaded contract to blockchain. Initial amount was
        // passed in the deploy migration
        balanceOf[msg.sender] = _initialSupply;
        totalSupply = _initialSupply;
        // allocate the intial token supply
    }

    function transfer(address _to, uint256 _value)
        public
        returns (bool success)
    {
        //checks if the balance (of the person triggering the contract)
        //is greater than or equal to the value being transfer to the transfer address

        require(balanceOf[msg.sender] >= _value);
        balanceOf[msg.sender] -= _value;
        balanceOf[_to] += _value;

        emit Transfer(msg.sender, _to, _value);
        return true;
    }
}
