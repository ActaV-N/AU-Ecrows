// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

contract Escrow {
	address public arbiter;
	address public beneficiary;
	address public depositor;

	bool public isApproved;

	constructor(address _arbiter, address _beneficiary) payable {
		arbiter = _arbiter;
		beneficiary = _beneficiary;
		depositor = msg.sender;
	}

	event Approved(uint balance);
    function approve() external{
        require(msg.sender == arbiter, "Should be an only arbiter");

        uint amount = address(this).balance;
        (bool success, ) = beneficiary.call{value:amount}("");
        require(success);

        isApproved = true;
        emit Approved(amount);
    }
}
