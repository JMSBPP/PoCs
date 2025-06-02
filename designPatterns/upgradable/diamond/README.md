# Diamond Proxy Pattern

We have that `CustomCurveAMMDiamond` is `DiamondProxy`

-  The `CustomCurveAMMDiamond` **determines** which `CustomCurveAMM` implementaion to __delegatecall__ based on the __function selector__ of the __calldata__ it receives.

- The  `CustomCurveAMMDiamond` can be upgraded by changing one or more of the `CustomCurveAMM`.  


When the `CustomCurveAMMDiamond` receives a transaction:

1.  **how does it know which `CustomCurveAMM` to call?**
2.  
## Examples:

### CSMM:
- If we were to provide liquidity on the uniswap-v4 fashion on CSMM curve, we have to consider the invariant
$$
R_X + R_Y = L
$$
