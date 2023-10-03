// SPDX-License-Identifier: MIT
pragma solidity ^0.5.0;

// token quantaToken, fist way to mint. buy tokens.
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/math/SafeMath.sol"; 

contract QuantaToken {

    using SafeMath for uint;

    address payable owner = msg.sender;
    string public symbol = "QTOK";
    uint public exchange_rate = 100; //initial exchange rate.
    
    mapping(address => uint) balances; // python dict, key, value 

    //check the bal
    function balance() public view returns (uint){
        return balances[msg.sender];
    }

    function transfer(address recipient, uint value) public {

    //require(balances[msg.sender] >= value, 'insufficent funds');


        balances[msg.sender] = balances[msg.sender].sub(value); // bal 0, 0 -1 = -1. overflow
        balances[recipient] = balances[recipient].add(value);

    }

    function purchase() public payable {

        uint amount = msg.value.mul(exchange_rate);
        balances[msg.sender] = balances[msg.sender].add(amount);
        owner.transfer(msg.value);
        
    }

    function mint(address recipient, uint value) public {
        require(msg.sender == owner, "only owner can mint");
        balances[recipient] = balances[recipient].add(value);
    }

    // function voteforAlgo(address algoAdress) public {
    //     //some logic for voting
    // }

    // function distributeProfit(){}

    // function addAlgo(address algoAddress) public {

    // }

    // //TODO: algo managment, review 

}

