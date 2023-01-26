//simple storage

// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

contract simple_storage{
    string private value;

    function setValue(string memory _value) public{
        value=_value;
    }
    function showValue() public view returns(string memory){
        return value;
    }
}
