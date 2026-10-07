// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;
import {Script, console} from "forge-std/Script.sol";
import {QSDG} from "../contracts/tokens/QSDG.sol";
import {QSDC} from "../contracts/tokens/QSDC.sol";
import {AllocationRegistry} from "../contracts/core/AllocationRegistry.sol";
import {LiquidityFloor} from "../contracts/core/LiquidityFloor.sol";
import {QuantumSwapEngine} from "../contracts/core/QuantumSwapEngine.sol";
contract DeployAll is Script {
    address constant USDT = 0x55d398326f99059fF775485246999027B3197955;
    address constant USDC = 0x8AC76a51cc950d9822D68b83fE1Ad97B32Cd580d;
    address constant QSDT = 0x3446704A41C555Eaa20214E189403Aa634221b77;
    function run() external {
        uint256 pk = vm.envUint("PRIVATE_KEY");
        address deployer = vm.addr(pk);
        vm.startBroadcast(pk);
        AllocationRegistry registry = new AllocationRegistry(deployer);
        LiquidityFloor floor = new LiquidityFloor(deployer);
        QuantumSwapEngine engine = new QuantumSwapEngine(deployer, address(floor));
        QSDG qsdg = new QSDG(deployer, address(registry));
        QSDC qsdc = new QSDC(deployer, address(registry));
        registry.registerToken(address(qsdg));
        registry.registerToken(address(qsdc));
        registry.registerToken(QSDT);
        uint256 floorPrice = 0.01 ether;
        uint256 rate = 0.01 ether;
        floor.configureFloor(address(qsdg), USDT, floorPrice);
        floor.configureFloor(address(qsdg), USDC, floorPrice);
        floor.configureFloor(address(qsdc), USDT, floorPrice);
        floor.configureFloor(address(qsdc), USDC, floorPrice);
        engine.addPair(address(qsdg), USDT, rate);
        engine.addPair(address(qsdg), USDC, rate);
        engine.addPair(address(qsdc), USDT, rate);
        engine.addPair(address(qsdc), USDC, rate);
        engine.addPair(QSDT, USDT, rate);
        engine.addPair(QSDT, USDC, rate);
        console.log("Registry:", address(registry));
        console.log("Floor:", address(floor));
        console.log("Engine:", address(engine));
        console.log("QSDG:", address(qsdg));
        console.log("QSDC:", address(qsdc));
        vm.stopBroadcast();
    }
}
