// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {Test, console2} from "forge-std/Test.sol";
import {Deployers, Currency} from "@uniswap/v4-core/test/utils/Deployers.sol";
import {PriceOracleHookUpgradable} from "../src/PriceOracleHookUpgradable.sol";
import {v3PriceOracle} from "../src/v3PriceOracle.sol";
import {UniswapV3Factory} from "./utils/UniswapV3Factory.sol";
import {WETH9} from "./utils/WETH9.sol";
import {v3SwapRouter} fropm "./utils/v3SwapRouter.sol";
import {IUniswapV3Factory} from "v3-core/interfaces/IUniswapV3Factory.sol";
import {IWETH9} from "v4-periphery/src/interfaces/external/IWETH9.sol";
import {ISwapRouter} from "v3-periphery/interfaces/ISwapRouter.sol";
import {Constants} from "@uniswap/v4-core/test/utils/Constants.sol";
contract PriceOracleHookUpgradableTest is Test, Deployers {
    PriceOracleHookUpgradable hook;
    v3PriceOracle priceOracle;
    IUniswapV3Factory v3factory;
    ISwapRouter v3Router;

    
    
    function setUp() public {
        UniswapV3Factory _v3factory = new UniswapV3Factory();
        address v3factoryAddress = _v3factory.deploy();
        v3factory = IUniswapV3Factory(v3factoryAddress);
        deployFreshManagerAndRouters();
        (currency0, currency1) = deployMintAndApprove2Currencies();
    }

    function deployV3Pool() internal returns(address){
        address _pool = v3factory.createPool(
            Currency.unwrap(currency0),
            Currency.unwrap(currency1),
            Constants.FEE_MEDIUM
        );
        return _pool;
    }

    function deployV3Router() internal returns(address){
        WETH9 _weth9 = new WETH9();
        IWETH9 weth9 = IWETH9((new WETH9()).deploy());
        v3SwapRouter _v3SwapRouter = new v3SwapRouter();


    }




}