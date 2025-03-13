// SPDX-License-Identifier: MIT

pragma solidity 0.8.17;

import {Test} from "@forge-std/Test.sol";
import {Benchmark} from "@level3/benchmark.sol";
import {Level3Template} from "@level3/solution.sol";
contract level3Test is Test {
    Benchmark private benchmark;
    Level3Template private level3;
    function setUp() public {
        benchmark = new Benchmark();
        level3 = new Level3Template();
    }

    function testEncodingPacked()
        external
        pure
        returns (bytes32 paddedData, uint16 _a, bool _b, bytes6 _c)
    {
        uint16 a = uint16(12);
        bool b = true;
        bytes6 c = hex"ffeedd000000"; // Last 4 bytes are zeros
        bytes memory packed = abi.encodePacked(a, b, c);
        assembly {
            mstore(0x80, packed)
            let data := mload(add(0x80, 0x40))
            let data2 := shr(184, data)

            //We have
            //paddedData :=
            // 0x0000000000000000000000000000000000000000000000000901ffeedd000000
            // we know need _a := 0x0009
            _a := shr(240, data)
            //              _b := 0x01
            _b := shr(48, shl(200, data2))
            _c := shl(208, data2)
            //              _c := 0xffeedd000000
            paddedData := data2
        }
    }

    function testSolutionInefficientUnit()
        external
        view
        returns (uint16 a, bool b, bytes6 c)
    {
        uint16 _a = uint16(12);
        bool _b = true;
        bytes6 _c = hex"ffeedd000000"; // Last 4 bytes are zeros
        bytes memory packed = abi.encodePacked(_a, _b, _c);
        (a, b, c) = level3.solution(packed);
        assertEq(_a, a);
        assertEq(_b, b);
        assertEq(_c, c);
    }

    function testSolutionInefficientFuzz(bytes memory packed) external {
        level3.solution(packed);
    }
}
