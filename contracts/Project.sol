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

    function subscribe() external payable {
        require(msg.value == subscriptionFee, "Incorrect subscription fee");
        subscribers[msg.sender] = block.timestamp;
    }

    function isSubscribed(address _user) external view returns (bool) {
        return subscribers[_user] > 0;
    }

    function withdraw() external onlyOwner {
        payable(owner).transfer(address(this).balance);
    }
}
