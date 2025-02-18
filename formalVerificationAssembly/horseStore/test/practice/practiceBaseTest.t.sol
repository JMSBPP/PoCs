// SPDX-License-Identifier: GPL-3.0-only
pragma solidity ^0.8.0;

import {Test} from "../../lib/forge-std/src/Test.sol";
import {IteratedMapping} from "../../src/practice/iteratedMapping.sol";
import {IiteratedMapping} from "../../src/practice/IiteratedMapping.sol";
import {practice} from "../../src/practice/practice.sol";
abstract contract practiceBaseTest is Test, practice {
    IiteratedMapping public iteratedMapping;

    function setUp() public virtual {
        iteratedMapping = IteratedMapping(address(new IteratedMapping()));
    }

    // function testWriteValues(address k1, uint256 k2, uint256 value) external {
    //     iteratedMapping.setOwnedTokensValue(k1, k2, value);
    //     uint256 k2Slot = uint256(keccak256(abi.encodePacked(k1, uint256(0))));
    //     uint256 storedValue;
    //     assembly {
    //         storedValue := sload(k2Slot)
    //     }

    //     assertEq(k2, storedValue);
    // }
}
