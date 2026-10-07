// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;
import {Ownable2Step, Ownable} from "@openzeppelin/contracts/access/Ownable2Step.sol";
contract AllocationRegistry is Ownable2Step {
    enum Category { GENESIS_RESERVE, PROTECTED_ALLOCATION, LIQUIDITY_INVENTORY, OPERATIONAL_TREASURY, CUSTODY }
    struct Allocation { Category category; uint256 amount; bool locked; string note; }
    mapping(address => mapping(address => Allocation)) public allocations;
    mapping(address => bool) public registeredTokens;
    event TokenRegistered(address indexed token);
    event Allocated(address indexed token, address indexed holder, Category category, uint256 amount, string note);
    constructor(address initialOwner) Ownable(initialOwner) {}
    function registerToken(address token) external onlyOwner { registeredTokens[token]=true; emit TokenRegistered(token); }
    function allocate(address token, address holder, Category category, uint256 amount, bool locked, string calldata note) external onlyOwner {
        require(registeredTokens[token], "not registered");
        allocations[token][holder] = Allocation(category, amount, locked, note);
        emit Allocated(token, holder, category, amount, note);
    }
}
