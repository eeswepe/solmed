// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract DonationContract {
    mapping(address => uint) public authorBalances;
    mapping(uint256 => uint) public postBalances;

    function donateToAuthor( address _author) public payable {
        require(_author != address(0), "Invalid author address");
        require(msg.value > 0, "Donation must be greater than 0");

        // Menambahkan saldo ke penulis dan ke post
        authorBalances[_author] += msg.value;
    }

    function donateToPost(uint _postId) public payable {
        require(msg.value > 0, "Donation must be greater than 0");

        postBalances[_postId] +=  msg.value;
    }

    function withdrawDonations() public {
        uint balance = authorBalances[msg.sender];
        require(balance > 0, "No funds to withdraw");

        authorBalances[msg.sender] = 0;
        payable(msg.sender).transfer(balance);
    }

}