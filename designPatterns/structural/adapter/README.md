
## Problem

- A server has a specialization whose services a requested by a client, but specialization interface is incompatible with client's interface

### Example

- Suppose an AMM has an interface to let users provide liquidity to a pool :

```typescript
struct ModifyLiquidityParams {
    int24 tickLower;
    int24 tickUpper;
    int256 liquidityDelta;
    bytes32 salt;
}
library Actions {
    // pool actions
    // liquidity actions
    uint256 internal constant INCREASE_LIQUIDITY = 0x00;
    uint256 internal constant DECREASE_LIQUIDITY = 0x01;
    uint256 internal constant MINT_POSITION = 0x02;
    uint256 internal constant BURN_POSITION = 0x03;
    uint256 internal constant INCREASE_LIQUIDITY_FROM_DELTAS = 0x04;
    uint256 internal constant MINT_POSITION_FROM_DELTAS = 0x05;
}


interface IBaseActionsRouter{
    /// @notice internal function that triggers the execution of a set of actions on v4
    /// @dev inheriting contracts should call this function to trigger execution
    function _executeActions(bytes calldata unlockData) internal {
        poolManager.unlock(unlockData);
    }
}

interface IPositionManager{
    /// @notice Unlocks Uniswap v4 PoolManager and batches actions for modifying liquidity
    /// @dev This is the standard entrypoint for the PositionManager
    /// @param unlockData is an encoding of actions, and parameters for those actions
    /// @param deadline is the deadline for the batched actions to be executed
    function modifyLiquidities(
        bytes calldata unlockData, 
        uint256 deadline
        ) external payable;

}
```


This is the **server** offering `modifyLiquidities` services to it's clients.

Now a `customCurveAMMPositionManager` wants to use the `modifyLiquidities` service of the `IPositionManager` server, however its interface is not compatible, _see below example_:

```typescript
library CustomCurveAMM{

}
interface ICustomCurveAMMPositionManager{

    function addLiquidity(
        address sender,
        PoolKey poolKey,
        uint256 amountX, 
        uint256 amountY
    ) external;

}
```

Then doing:

```typescript

abstract contract CustomCurveAMMPositionManager is ICustomCurveAMMPositionManager{
    
    IPositionManager private uv4PositionManager;
    
    function addLiquidity(
        address sender,
        PoolKey poolKey,
        uint256 amountX, 
        uint256 amountY
    ) external
    {
     bytes memory liquidityOrderData =    uv4PositionManager.modifyLiquidities(abi.encode(sender, poolkey, amountX, amountY))
    }
}

```

Would not be of much help since the `IPositionManager` __server's interface__ is **incompatible** with __client's interface__ `ICustomCurveAMMPositionManager`




## Solution

- Create a __adapter server__ which main service is to have the __server's interface__ **adapt** to the __client's interface__

### Example

- - Create a `PositionManagerAdapter` which main service is to have the `PoolManager` **adapt** to the `CustomCurveAMMPositionManager`

 