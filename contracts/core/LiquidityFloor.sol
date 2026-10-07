// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;
import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import {SafeERC20} from "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";
import {Ownable2Step, Ownable} from "@openzeppelin/contracts/access/Ownable2Step.sol";
import {ReentrancyGuard} from "@openzeppelin/contracts/utils/ReentrancyGuard.sol";
contract LiquidityFloor is Ownable2Step, ReentrancyGuard {
    using SafeERC20 for IERC20;
    struct FloorConfig { uint256 floorPrice; address quoteToken; uint256 reserveBalance; bool active; }
    mapping(address => FloorConfig) public floors;
    mapping(address => bool) public supportedTokens;
    constructor(address initialOwner) Ownable(initialOwner) {}
    function configureFloor(address token, address quoteToken, uint256 floorPrice) external onlyOwner {
        floors[token] = FloorConfig(floorPrice, quoteToken, floors[token].reserveBalance, true);
        supportedTokens[token]=true;
    }
    function getFloor(address token) external view returns (uint256, address, uint256, bool) {
        FloorConfig memory f = floors[token];
        return (f.floorPrice, f.quoteToken, f.reserveBalance, f.active);
    }
}
