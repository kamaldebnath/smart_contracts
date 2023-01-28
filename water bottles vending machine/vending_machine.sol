// water bottles vending machine

// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;
contract vending_machine{
    address private owner; //owner of the vending machine
    mapping(address => uint)public balance; //no of water bottles

    constructor(uint _balance){
        owner=msg.sender;  //setting the owner
        balance[address(this)]=_balance;  //initial balance (no of water bottles)
    }


    // only owner
    modifier onlyOwner(){
        require(owner==msg.sender,"You are not the owner of the vending machine!");
        _;
    }

    //function to transfer ownership of the vending machine
    function transferOwner(address newOwner) public{
        owner=newOwner;
    }


    // function to purchase water bottles
    function purchase(uint amount) payable public{
        require(msg.value >= amount * 2 ether,"You have to pay 2 eth per bottle");
        require(balance[address(this)] >= amount,"Not enough bottles left");
        balance[address(this)]=balance[address(this)]-amount;
        balance[msg.sender]=balance[msg.sender]+amount;


    }

    //funtion to restock the vending machine
    function restock(uint supply) onlyOwner public{

        balance[address(this)] += supply;

    }

    //function to get the balance of the vending machine

    function getBalance() public view returns (uint){
        return balance[address(this)];
    }

    //function to check total eth in the contract

    function ethBalance() public view returns(uint){
        return address(this).balance;
    }

    //function for owner to withdraw profit
    function withdraw() onlyOwner public{
        payable(owner).transfer(address(this).balance);
    }




}
