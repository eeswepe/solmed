// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import './User.sol';
import './Donation.sol';

contract PostContract {

    uint postId;
    UserContract contractUser;
    DonationContract contractDonation;

    struct Post {
        address author;
        string content;
        uint uploadedAt;
        uint like;
    }

    mapping(uint256 => Post) public posts;
    mapping(uint256 => mapping(address => bool)) hasLike;

    constructor(address _userContract, address _donationContract) {
        contractUser = UserContract(_userContract);
        contractDonation = DonationContract(_donationContract);
        postId = 0;
    }


    function createPost(string memory _content) public {
        require(contractUser.isUserRegistered(msg.sender), "User is not registered!");

        postId++;
        posts[postId] = Post({
            author: msg.sender,
            content: _content,
            uploadedAt: block.timestamp,
            like: 0
        });

        contractUser.addingPost(msg.sender);
    }

    function likePost(uint _postId) public {
        require(contractUser.isUserRegistered(msg.sender), "You are not registered!");
        // require(!hasLike[_postId][msg.sender], "You already like this post");
        if(!hasLike[_postId][msg.sender]){
            posts[_postId].like++;
            hasLike[_postId][msg.sender] = true;
        }
        else{
            posts[_postId].like--;
            hasLike[_postId][msg.sender] = false;
        }
    }

    function updatePost(uint _postId, string memory _newContent) public {
        require(posts[_postId].author == msg.sender, "You are not the author of this post");
        posts[_postId].content = _newContent;
    }

    function deletePost(uint _postId) public {
        require(posts[_postId].author == msg.sender, "You are not the author of this post");
        delete posts[_postId];
    }

    function isPostExist(uint _postId) external view returns(bool){
        return 
    }

}
