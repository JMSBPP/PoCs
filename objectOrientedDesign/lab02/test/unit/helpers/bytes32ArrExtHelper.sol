import {bytes32ArrayExt} from "../../../src/libraries/bytes32ArrayExt.sol";

contract bytes32ArrExtHelper {
    using bytes32ArrayExt for bytes32[];
    function isSubsetFalse() external pure returns (bool) {
        bytes32[] memory subset = new bytes32[](2);
        subset[0] = bytes32(uint256(0x00));
        subset[1] = bytes32(uint256(0x01));
        bytes32[] memory referencePowerSet = new bytes32[](3);
        referencePowerSet[0] = bytes32(uint256(0x02));
        referencePowerSet[1] = bytes32(uint256(0x01));
        referencePowerSet[2] = bytes32(uint256(0x04));
        return subset.isSubsetOf(referencePowerSet);
    }

    function isSubsetTrue() external pure returns (bool) {
        bytes32[] memory subset = new bytes32[](2);
        subset[0] = bytes32(uint256(0x02));
        subset[1] = bytes32(uint256(0x03));
        bytes32[] memory referencePowerSet = new bytes32[](3);
        referencePowerSet[0] = bytes32(uint256(0x02));
        referencePowerSet[1] = bytes32(uint256(0x03));
        referencePowerSet[2] = bytes32(uint256(0x04));
        return subset.isSubsetOf(referencePowerSet);
    }
}
