// SPDX-License-Identifier: MIT

pragma solidity 0.8.17;

/////////////////// ☆☆ extropyio ☆☆ /////////////////////
//     -漫~*'¨¯¨'*·舞~ solidity ctf ~舞·*'¨¯¨'*~漫-     //
/////////////////////////////////////////////////////////

/*
interface Isolution4 {
    function solution(uint256 number) external pure returns (uint256);
}
*/
import {Math} from "@math/Math.sol";
import {SafeMath} from "@math/SafeMath.sol";

contract Level4Template {
    using Math for uint256;
    using SafeMath for uint256;
    // stdin: 1                     stdout: 1 or 2**0
    // stdin: 10                    stdout: 8 or 2**3
    // stdin: 21                    stdout: 16 or 2**4
    // stdin: 2048                  stdout: 2048 or 2**11
    // stdin: 9223372036854775808   stdout: 9223372036854775808 or 2**63
    // stdin: 0xffffffff            stdout: 2147483648 or 0x80000000 or 2**31
    constructor() payable {}
    function solution(uint256 number) external pure returns (uint256) {
        // TODO: Write your solution here
        uint256 power = number.log2();
        uint256 result = _pow(2, power);
        return result;
    }

    function _pow(uint256 n, uint256 e) private pure returns (uint256) {
        if (e == 0) {
            return 1;
        } else if (e == 1) {
            return n;
        } else {
            uint p = _pow(n, e.div(2));
            p = p.mul(p);
            if (e.mod(2) == 1) {
                p = p.mul(n);
            }
            return p;
        }
    }
}
