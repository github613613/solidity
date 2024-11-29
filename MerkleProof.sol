// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// 默克尔智能合约
contract MerkleProof {
    bytes32[] public hashes;

    // 生成默克尔树
    function generateMerkleTree(string[] memory trangactions) public {
        for (uint i = 0; i < trangactions.length; i++){
            hashes.push(keccak256(abi.encodePacked(trangactions[i])));
        }

    uint256 n = trangactions.length;
    uint offset = 0;

    while (n > 0) {
        for(uint i = 0; i < n - 1; i += 2){
            hashes.push(
                keccak256(
                    abi.encodePacked(hashes[offset+i], hashes[offset + i + 1])
                )
            );
        }
    }

    offset += n;

    n /= 2;

    }

    // 验证默克尔证明
    function verify(
        bytes32[] memory proof,
        bytes32 root,
        bytes32 leaf,
        uint index
    ) public pure returns(bool){
        bytes32 hash = leaf;

        for(uint i = 0; i < proof.length; i++){
            bytes32 proofElement = proof[i];

            if(index % 2 == 0) {
                hash = keccak256(abi.encodePacked(hash, proofElement));
            } else {
                hash = keccak256(abi.encodePacked(proofElement, hash));
            }
            
            index /= 2;
        }

        return hash == root;
    }
    

    //获取默克尔树根
    function getRoot() public view returns (bytes32) {
        return hashes[hashes.length - 1];
    }

}

//测试默克尔证明合约
contract TestMerkleProof is MerkleProof{
    string[] public transactions;
    
    constructor() {
        transactions.push("alice -> bob");
        transactions.push("bob -> dave");
        transactions.push("carol -> alice");
        transactions.push("dave -> bob");

        //生成默克尔树
        generateMerkleTree(transactions);
    }

}