pragma solidity ^0.5.16;

contract mikeToken{
    //declaring state variable public will implicitly create a getter for totalSupply
    uint256 public totalSupply;
    constructor() public {
        totalSupply = 1000000;
    }
}