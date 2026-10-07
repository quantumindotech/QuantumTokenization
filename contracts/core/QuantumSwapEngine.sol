// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;
import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import {SafeERC20} from "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";
import {Ownable2Step, Ownable} from "@openzeppelin/contracts/access/Ownable2Step.sol";
import {ReentrancyGuard} from "@openzeppelin/contracts/utils/ReentrancyGuard.sol";
contract QuantumSwapEngine is Ownable2Step, ReentrancyGuard {
    using SafeERC20 for IERC20;
    struct Pair { address token; address quote; uint256 rate; bool active; }
    mapping(bytes32 => Pair) public pairs;
    constructor(address initialOwner, address _liquidityFloor) Ownable(initialOwner) {}
    function addPair(address token, address quote, uint256 rate) external onlyOwner {
        bytes32 key = keccak256(abi.encodePacked(token, quote));
        pairs[key] = Pair(token, quote, rate, true);
    }
    function updateRate(address token, address quote, uint256 newRate) external onlyOwner {
        bytes32 key = keccak256(abi.encodePacked(token, quote));
        pairs[key].rate = newRate;
    }
}
