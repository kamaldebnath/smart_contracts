//test network faucet provider

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.6;
contract faucet{
    struct last_user_deposit{
        uint time;
        uint amount;
    }

    struct last_user_withdraw{
        uint time;
        uint amount;
    
    }
    mapping(address => last_user_deposit) private map_last_deposit;
    mapping(address => last_user_withdraw) private map_last_withdraw;
    mapping(address => uint) public total_deposit_value;



    // function to deposit ether faucet 
    function deposit() payable public{
        map_last_deposit[msg.sender]=last_user_deposit(block.timestamp,msg.value);
        total_deposit_value[msg.sender] +=msg.value;
    } 

    // function to check if user is eligible to withdraw faucet or not
    function check_Eligibility(address wallet) private view returns(bool){
        if(block.timestamp-map_last_withdraw[wallet].time >=86400){
            return true;
        }
        else{
            return false;
        }
        
    }

    // function to withdraw
    function withdraw() public{
        require(check_Eligibility(msg.sender),"You can claim once a day only");
        require(address(this).balance >= 0.5 ether, "Not enough faucet avilable at this moment");
        payable(msg.sender).transfer(0.5 ether);
        map_last_withdraw[msg.sender]=last_user_withdraw(block.timestamp,0.5 ether);
    }

    function avilable_faucet() public view returns(uint){
        return address(this).balance;
    }
}
