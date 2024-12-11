// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract AccessControl {

    // 定义角色
    bytes32 public constant ADMIN_ROLE = keccak256("ADMIN_ROLE");
    bytes32 public constant USER_ROLE = keccak256("USER_ROLE");

    // 定义事件
    event AdminAdded(address indexed account);
    event AdminRemoved(address indexed account);
    event UserAdded(address indexed account);
    event UserRemoved(address indexed account);

    // 管理员角色
    struct Admin {
        bool exists;
        uint256 index;
    }

    // 用户角色
    struct User {
        bool exists;
        uint256 index;
    }

    // 所有角色的账户
    address[] public admins;
    address[] public users;

    // 存储角色对应的账户
    mapping (address => Admin) private adminAccounts;
    mapping (address => User) private userAccounts;

    // 仅允许管理员访问的函数
    modifier onlyAdmin() {
        require(isAdmin(msg.sender),unicode"你不是管理员!");
        _;
    }


    // 仅允许管理员访问的函数
    modifier onlyUser() {
        require(isUser(msg.sender),unicode"你不是用户!");
        _;
    }

    
    
    
}