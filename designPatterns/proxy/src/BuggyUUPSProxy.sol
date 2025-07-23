// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {ERC1967Proxy} from "openzeppelin-contracts/contracts/proxy/ERC1967/ERC1967Proxy.sol";
import {Constants} from "@uniswap/v4-core/test/utils/Constants.sol";

contract BuggyUUPSProxy is ERC1967Proxy {
    constructor(
        address _implementation
    ) payable ERC1967Proxy(_implementation, Constants.ZERO_BYTES) {}
}
