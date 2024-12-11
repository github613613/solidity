pragma solidity ^0.4.18;
contract HelloWorld {
    string msg = 'Hello World';
    function helloworld(string _msg) public {
        msg = _msg;
    }
    function say() constant public returns (string) {
        return msg;
    }
}