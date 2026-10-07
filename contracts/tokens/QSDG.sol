// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;
import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import {ERC20Permit} from "@openzeppelin/contracts/token/ERC20/extensions/ERC20Permit.sol";
import {ERC20Burnable} from "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import {Ownable2Step, Ownable} from "@openzeppelin/contracts/access/Ownable2Step.sol";
import {Pausable} from "@openzeppelin/contracts/utils/Pausable.sol";
contract QSDG is ERC20, ERC20Permit, ERC20Burnable, Ownable2Step, Pausable {
    uint256 public constant GENESIS_SUPPLY = 1_000_000_000 * 10 ** 18;
    address public allocationRegistry;
    address public masterController;
    event AllocationRegistryUpdated(address indexed newRegistry);
    event MasterControllerUpdated(address indexed newController);
    constructor(address initialOwner, address _allocationRegistry) ERC20("Trisula Gold", "QSDG") ERC20Permit("Trisula Gold") Ownable(initialOwner) {
        allocationRegistry = _allocationRegistry;
        _mint(initialOwner, GENESIS_SUPPLY);
    }
    modifier onlyRegistryOrOwner() { require(msg.sender == allocationRegistry || msg.sender == owner(), "not authorized"); _; }
    function setAllocationRegistry(address _registry) external onlyOwner { allocationRegistry = _registry; emit AllocationRegistryUpdated(_registry); }
    function setMasterController(address _controller) external onlyOwner { masterController = _controller; emit MasterControllerUpdated(_controller); }
    function mint(address to, uint256 amount) external onlyRegistryOrOwner whenNotPaused { _mint(to, amount); }
    function pause() external onlyOwner { _pause(); }
    function unpause() external onlyOwner { _unpause(); }
    function _update(address from, address to, uint256 value) internal override whenNotPaused { super._update(from, to, value); }
}
