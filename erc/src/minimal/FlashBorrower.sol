// SPDX-License-Identifier: MIT
pragma solidity >=0.6.6;

import {FlashLender} from "./FlashLender.sol";

contract FlashBorrower {
    FlashLender lender;

    constructor(FlashLender _lender) {
        lender = _lender;
    }

    function initiateBorrow(uint256 bal) external payable {
        lender.flashBorrow(bal);
    }

    function onFlashLoan(uint256 amount) external payable returns (bytes32) {
        require(msg.sender == address(lender), "only flash lender");
        // Do something with the borrowed amount
        // ...
        (bool ok, ) = address(lender).call{value: amount}("");
        require(ok, "transfer failed");

        return keccak256("BorrowMoney");
    }
}
