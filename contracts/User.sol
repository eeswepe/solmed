// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract UserContract {
    struct User{
        address userAddress;
        string username;
        uint postCounts;
    }

    mapping(address => User) public users;

    // Fungsi untuk mendaftarkan user
    function register(string memory _username) public {
        require(bytes(users[msg.sender].username).length == 0, "User already registered");
        
        users[msg.sender] = User({
            userAddress: msg.sender,
            username: _username,
            postCounts: 0
        });
    }

    // Fungsi untuk menambah postCount user, dengan parameter address user
    function addingPost(address _user) external {
        require(bytes(users[_user].username).length != 0, "Please Register first");
        users[_user].postCounts++;
    }

    // Fungsi untuk mengecek apakah user sudah terdaftar
    function isUserRegistered(address _user) external  view returns (bool) {
        return bytes(users[_user].username).length != 0;
    }
}
