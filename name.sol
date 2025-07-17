// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

/// @title SimpleKickstarter
/// @notice Basic crowdfunding contract example
contract SimpleKickstarter {
    address public owner;
    uint public goal;
    uint public raised;
    mapping(address => uint) public contributions;

    event ContributionReceived(address contributor, uint amount);
    event FundsWithdrawn(address recipient, uint amount);

    constructor(uint _goal) {
        owner = msg.sender;
        goal = _goal;
    }

    function contribute() external payable {
        require(msg.value > 0, "Must send ETH");
        contributions[msg.sender] += msg.value;
        raised += msg.value;
        emit ContributionReceived(msg.sender, msg.value);
    }

    function withdraw() external {
        require(msg.sender == owner, "Only owner");
        require(raised >= goal, "Goal not reached");
        uint amount = address(this).balance;
        (bool sent, ) = owner.call{value: amount}("");
        require(sent, "Withdraw failed");
        emit FundsWithdrawn(owner, amount);
    }
}
