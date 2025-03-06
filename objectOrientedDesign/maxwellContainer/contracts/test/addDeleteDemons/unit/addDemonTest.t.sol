//SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Test} from "@forge-std/Test.sol";
import {maxwellContainerClient} from "@maxwellContainer/client.sol";
import {CreateStateHandler} from "../../createStateHandler.sol";
import {types} from "@types/types.sol";

contract addDemonTest is Test, CreateStateHandler, types {
    maxwellContainerClient private client;
    address dummyOwner = address(1);
    function setUp() public {
        client = new maxwellContainerClient(dummyOwner);
    }

    function testShouldAddDemon() external {
        vm.startPrank(dummyOwner);
        client.create(WIDTH, HEIGHT);
        client.addDemon(1);
        address demons = client.getDemons();
        (, bytes memory data) = demons.staticcall(
            abi.encodeWithSignature("getDemon(uint256)")
        );
        vm.stopPrank();
        address demonAddress = abi.decode(data, (address));
        assertNotEq(address(0), demonAddress);
    }
}
