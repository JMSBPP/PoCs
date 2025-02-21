// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

interface IgraphCalculatorLogic {
    error nameAlreadyExists();

    function create(string memory name) external;
    function assign(
        string memory graphName,
        string[] memory vertices,
        string[][] memory edges
    ) external;
}
