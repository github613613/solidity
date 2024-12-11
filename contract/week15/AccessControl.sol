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
        require(isAdmin(msg.sender), unicode"你不是管理员!");
        _;
    }


    // 仅允许管理员访问的函数
    modifier onlyUser() {
        require(isUser(msg.sender), unicode"你不是正确用户!");
        _;
    }

    // 添加管理员角色
    function addAdmin(address account) public onlyAdmin {
        require(!adminAccounts[account].exists, " ");
        adminAccounts[account] = Admin(true, admins.length);
        admins.push(account);
        emit AdminAdded(account);
    }

    // 删除管理员角色
    function removeAdmin(address account) public onlyAdmin {
        require(adminAccounts[account].exists," ");
        uint256 indexToDelete = adminAccounts[account].index;
        address accountToMove = admins[admins.length - 1];
        admins[indexToDelete] = accountToMove;
        adminAccounts[accountToMove].index = indexToDelete;
        admins.pop();
        delete adminAccounts[account];
        emit AdminRemoved(account);
    }


    // 添用户角色
    function addUser(address account) public onlyAdmin {
        require(!userAccounts[account].exists, " ");
        userAccounts[account] = User(true, users.length);
        users.push(account);
        emit UserAdded(account);
    }

    // 删除用户角色
    function removeUser(address account) public onlyAdmin {
        require(userAccounts[account].exists," ");
        uint256 indexToDelete = userAccounts[account].index;
        address accountToMove = users[users.length - 1];
        users[indexToDelete] = accountToMove;
        userAccounts[accountToMove].index = indexToDelete;
        users.pop();
        delete userAccounts[account];
        emit UserRemoved(account);
    }
    
    function isAdmin(address account) public view returns (bool) {
        return adminAccounts[account].exists;
    }

    function isUser(address account) public view returns (bool) {
        return userAccounts[account].exists;
    }
}