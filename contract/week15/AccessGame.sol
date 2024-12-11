// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract AccessGame {

    uint totalSupply = 0;
    address public owner;
    mapping (address => uint256) public balances;

    event SendBouns(address _who, uint bouns);
    modifier onlyOwner{
        if(msg.sender != owner)
        revert();
        _;
    }

    constructor() {
        initOwner(msg.sender);
    }
    //  修复前
    // function initOwner(address _owner) internal {
    //     owner = _owner;
    // }

    function initOwner(address _owner) internal {
        owner = _owner;
    }

    function BounsSend(address lucky, uint bouns) public onlyOwner returns(uint) {
        require(balances[lucky] < 1000);
        require(bouns < 200);
        balances[lucky] += bouns;
        totalSupply += bouns;
        emit SendBouns(lucky, bouns);
        return balances[lucky];
    }
    
}