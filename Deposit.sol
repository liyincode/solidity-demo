// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

contract Deposit {
    mapping(address => uint256) private _balances;

    receive() external payable {
        deposit();
    }

    function deposit() public payable {
        _balances[msg.sender] += msg.value;
    }

    function withdraw(uint256 amount) public {
        require(_balances[msg.sender] >= amount, "Insufficient balance");
        _balances[msg.sender] -= amount;

        (bool success,) = msg.sender.call{value: amount}("");
        require(success, "Transfer failed.");
    }

    function ownerWithdraw() public {
        uint256 amount = _balances[msg.sender];
        require(amount > 0, "Insufficient balance");

        _balances[msg.sender] = 0;

        (bool success,) = msg.sender.call{value: amount}("");
        require(success, "Transfer failed.");
    }

    function balanceOf(address account) public view returns (uint256) {
        return _balances[account];
    }
}
