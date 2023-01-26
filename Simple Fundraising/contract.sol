

//fund raiser smart contract




// SPDX-License-Identifier: MIT


pragma solidity >=0.6.0 <0.8.17;

contract project{
    address payable private owner = payable(msg.sender);
    address[]  donors;

    mapping(address => uint) public donation;

    modifier onlyOwner{
        require(owner==msg.sender,"You are not the Owner");
        _;
    }
    function deposit() payable public{
        donors.push(msg.sender);
        donation[msg.sender]=msg.value;
    }

    function withdraw() public onlyOwner{
        owner.transfer(address(this).balance);
    }
    function totalDonation() public view returns(uint){
        return address(this).balance;
    }

    function getDonorsList() public view returns(address[] memory){
        return donors;
    }

   }
