//SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.25;

import "./interfaces/ICustomCurve.sol";

contract CustomCurveAMMImmutableDiamond {
    bytes4 constant MODIFY_LIQUIDITY = ICustomCurve.modifyLiquidity.selector;
    bytes4 constant SWAP = ICustomCurve.swap.selector;
}
