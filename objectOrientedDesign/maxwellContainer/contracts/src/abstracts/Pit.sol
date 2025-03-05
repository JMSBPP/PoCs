//SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "../shapes.sol";

abstract contract Pit is Circle {
    Rectangle private innerFrame;
    Rectangle private frame;
    Circle[] private particles;

    uint256 private particlesCount;
    uint256 private maxNumberOfParticles;

    constructor(
        uint256 pitDiameter,
        Size memory innerFrameSize,
        Size memory frameSize
    ) Circle() {}

    /**
     * @dev Puts a number of particles in the pit.
     * @param numbParticles The number of particles to add.
     */
    function putParticles(uint256 numbParticles) external virtual;

    /**
     * @dev Removes a number of particles from the pit.
     * @param numbParticles The number of particles to remove.
     */
    function removeParticles(uint256 numbParticles) external virtual;

    /**
     * @dev Returns the current number of particles in the pit.
     */
    function getParticlesCount() public view returns (uint256 _particles) {
        _particles = particlesCount;
    }
}
