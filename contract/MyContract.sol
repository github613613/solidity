// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract MyContract {

    function add(int8 a, int8 b) public pure returns(int256) {
        return a + b;
    }
    
}

contract Test {
    
    function get_big_value() public pure returns (int){
        return (2**200);
    }

    function test_overflow(int a) public pure returns (int) {
        return (a * 2);
    }

}