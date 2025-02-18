//SPDX-Licnse-Identifier: MIT
pragma solidity ^0.8.0;

contract amountSentSolidity {
    function getAmountSent() public payable returns (uint256) {
        return msg.value;
    }
}
