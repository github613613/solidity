// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SelectorClash {
    
    bool public solved;

    function putCurEpochConPubKeyBytes(bytes memory _bytes) public {
        require(msg.sender == address(this), "Not Owner");
        solved = true;
    }

    function executeCrossChainTx(bytes memory _method, bytes memory _bytes, bytes memory _byte1, uint64 _num) public returns (bool success){
        (success, ) = address(this).call(abi.encodePacked(bytes4(keccak256(abi.encodePacked(_method, "(bytes,bytes,uint64)"))), abi.encode(_bytes,_byte1,_num)));
    }
}