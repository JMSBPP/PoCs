// SPDX-License-Identifier: MIT
pragma solidity >=0.6.6;

import {FlashBorrower} from "./FlashBorrower.sol";
contract FlashLender {
    receive() external payable {}

    function flashBorrow(uint256 bal) external {
        bytes32 ret = FlashBorrower(msg.sender).onFlashLoan{value: 1 ether}(
            bal
        );
        // expect it back on the same transaction
        require(ret == keccak256("BorrowMoney"), "invalid response");
        require(address(this).balance >= bal, "flash loan not paid back");
    }
}
