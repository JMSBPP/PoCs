// SPDX-License-Identifier: GPL-3.0-only
pragma solidity ^0.8.0;

import {IiteratedMapping} from "./IiteratedMapping.sol";
contract IteratedMapping is IiteratedMapping {
    mapping(address => mapping(uint256 => uint256)) public _ownedTokens;

    function setOwnedTokensValue(address k1, uint256 k2, uint256 value) public {
        _ownedTokens[k1][k2] = value;
    }
}
