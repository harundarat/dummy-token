// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Capped.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract DummyToken is ERC20Burnable, ERC20Capped, Ownable {
    uint256 public blockReward;

    constructor(uint256 cap, uint256 reward) Ownable(msg.sender) ERC20("Dummy Token", "DMT") ERC20Capped(cap * (10 ** decimals())) {
        _mint(msg.sender, 21000000 * (10 ** decimals()));
        blockReward = reward * (10 ** decimals());
    }

    function _update(address from, address to, uint256 value) internal override(ERC20, ERC20Capped) {
        super._update(from, to, value);
    }

    function _mintMinerReward() internal {
        _mint(block.coinbase, blockReward);
    }

    function _beforeTokenTransfer(address from, address to) internal virtual {
        if (from != address(0) && to != block.coinbase && block.coinbase != address(0)) {
            _mintMinerReward();
        }
    }

    function setBlockReward(uint256 reward) public onlyOwner {
        blockReward = reward * (10 ** decimals());
    }

    function destroy() public onlyOwner {
        address payable addr = payable(owner());
        selfdestruct(addr);
    }


}