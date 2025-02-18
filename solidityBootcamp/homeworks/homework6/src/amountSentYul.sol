//SPDX-Licnse-Identifier: MIT
pragma solidity ^0.8.0;

contract amountSentYul {
    function getAmountSent() public payable returns (uint256 valueSent) {
        assembly {
            valueSent := callvalue()
        }
    }
}
