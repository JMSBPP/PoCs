// SPDX-License-Identifier: MIT
pragma solidity ^0.8.3;

import {MathMasters} from "../src/MathMasters.sol";

contract CompactCodeBase {
    using MathMasters for uint256;
    function uniSqrt(uint256 x) external pure returns (uint256 z) {
        z = MathMasters.uniSqrt(x);
    }

    function solmateSqrt(uint256 x) external pure returns (uint256 z) {
        z = MathMasters.solmateSqrt(x);
    }

    function mathMastersSqrt(uint256 x) external pure returns (uint256 z) {
        z = MathMasters.sqrt(x);
    }

    function topHalfSolmateSqrt(uint256 x) external pure returns (uint256 z) {
        assembly {
            let y := x

            z := 181
            if iszero(lt(y, 0x10000000000000000000000000000000000)) {
                y := shr(128, y)
                z := shl(64, z)
            }
            if iszero(lt(y, 0x1000000000000000000)) {
                y := shr(64, y)
                z := shl(32, z)
            }
            if iszero(lt(y, 0x10000000000)) {
                y := shr(32, y)
                z := shl(16, z)
            }
            if iszero(lt(y, 0x1000000)) {
                y := shr(16, y)
                z := shl(8, z)
            }

            z := shr(18, mul(z, add(y, 65536)))
        }
    }

    function topHalfMathMasterSqrt(
        uint256 x
    ) external pure returns (uint256 z) {
        assembly {
            z := 181

            // This segment is to get a reasonable initial estimate for the Babylonian method. With a bad
            // start, the correct # of bits increases ~linearly each iteration instead of ~quadratically.
            let r := shl(7, lt(87112285931760246646623899502532662132735, x))
            r := or(r, shl(6, lt(4722366482869645213695, shr(r, x))))
            r := or(r, shl(5, lt(1099511627775, shr(r, x))))
            // Correct: 16777215 0xffffff
            r := or(r, shl(4, lt(0xffffff, shr(r, x))))
            z := shl(shr(1, r), z)

            // There is no overflow risk here since `y < 2**136` after the first branch above.
            z := shr(18, mul(z, add(shr(r, x), 65536))) // A `mul()` is saved from starting `z` at 181.
        }
    }
}
