// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {BaseTestv2, HorseStore} from "./BaseTestv2.t.sol";
import {HuffDeployer} from "@HUFF/HuffDeployer.sol";

contract HorseStoreHuffV2 is BaseTestv2 {
    string public constant horseStoreLocation = "v2/HorseStore";

    function setUp() public override {
        horseStore = HorseStore(
            HuffDeployer
                .config()
                .with_args(
                    bytes.concat(abi.encode(NFT_NAME), abi.encode(NFT_SYMBOL))
                )
                .deploy(horseStoreLocation)
        );
    }
}
