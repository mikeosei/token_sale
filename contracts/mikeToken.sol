pragma solidity ^0.5.16;

contract mikeToken {
    uint256 public totalSupply;

    string public name = "Mike Token";

    string public symbol = "MIKE";

    string public standard = "Mike Token v1.0";

    /// @notice balanceOf maps addresses to balances
    mapping(address => uint256) public balanceOf;

    /// @notice Allowance maps owner adresses to the allowance a uint256 amount for a given spender address
    mapping(address => mapping(address => uint256)) public allowance;

    event Transfer(address indexed _from, address indexed _to, uint256 _value);

    event Approval(
        address indexed _owner,
        address indexed _spender,
        uint256 _value
    );

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

    /// @notice approve() allows _spender to withdraw from you account up to the _value amount.
    /// The allowance is then stored globalling in the allowance mapping
    /// @param _spender address that is approved to spend valued amount
    /// @param _value amount of tokens spender is allowed to spend

    function approve(address _spender, uint256 _value)
        public
        returns (bool success)
    {
        allowance[msg.sender][_spender] = _value;
        emit Approval(msg.sender, _spender, _value);
        return true;
    }

    /// @notice tranferFrom handles a delegated token transfer where an approved spending account can withdraw
    /// @notice and transfer funds from a given account _from to a and a given account _to
    function transferFrom(
        address _from,
        address _to,
        uint256 _value
    ) public returns (bool success) {
        //require value not to exceed balance of owner's account
        require(_value <= balanceOf[_from]);
        //return value not to exceed allowance
        require(_value <= allowance[_from][msg.sender]);

        //change balance
        balanceOf[_from] -= _value;
        balanceOf[_to] += _value;
        
        //update allowance
        allowance[_from][msg.sender] -= _value;

        emit Transfer(_from, _to, _value);

        return true;
    }
}
