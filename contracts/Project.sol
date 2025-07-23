// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SubscriptionService {
    address public owner;
    uint256 public subscriptionFee;
    mapping(address => uint256) public subscribers;

    constructor(uint256 _fee) {
        owner = msg.sender;
        subscriptionFee = _fee;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Not the contract owner");
        _;
    }

    // Function to subscribe by paying the fee
    function subscribe() external payable {
        require(msg.value == subscriptionFee, "Incorrect subscription fee");
        subscribers[msg.sender] = block.timestamp;
    }

    // Check if a user is subscribed
    function isSubscribed(address _user) external view returns (bool) {
        return subscribers[_user] > 0;
    }

    // NEW: Get the timestamp of when a user subscribed
    function subscriptionTimestamp(address _user) external view returns (uint256) {
        require(subscribers[_user] > 0, "User is not subscribed");
        return subscribers[_user];
    }

    // Withdraw collected funds (only owner)
    function withdraw() external onlyOwner {
        payable(owner).transfer(address(this).balance);
    }
}
