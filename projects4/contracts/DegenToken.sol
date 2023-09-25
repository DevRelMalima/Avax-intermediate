// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract DegenToken is ERC20, Ownable {

    // Mapping to store the redemption rates for different items
    mapping(uint256 => uint256) private _itemRedemptionRates;

    // Event emitted when an item is redeemed
    event ItemRedeemed(address indexed user, uint256 itemId, uint256 amount);

    constructor() ERC20("Degen", "DGN") {}

    /**
     * @dev Mints new tokens and assigns them to the specified address.
     * Can only be called by the contract owner.
     */
    function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }

    /**
     * @dev Transfers tokens from the sender's account to the specified account.
     * Overrides the transfer function in ERC20.sol.
     */
    function transfer(address to, uint256 amount) public override returns (bool) {
        _transfer(_msgSender(), to, amount);
        return true;
    }

    /**
     * @dev Redeems tokens for a specific item based on the input amount.
     * The specified amount of tokens is destroyed and removed from circulation.
     * The redeemed item's ID and corresponding rate should be provided.
     */
    function redeem(uint256 amount, uint256 itemId) public {
        // Ensure the provided item ID is valid
        require(_itemRedemptionRates[itemId] > 0, "Invalid item ID");
        
        // Calculate the total tokens required for the redemption
        uint256 tokensRequired = _itemRedemptionRates[itemId] * amount;
        
        // Ensure the user has sufficient balance for the redemption
        require(balanceOf(msg.sender) >= tokensRequired, "Insufficient balance");
        
        // Burn the tokens from the user's account
        _burn(msg.sender, tokensRequired);
        
        // Emit an event to indicate the successful item redemption
        emit ItemRedeemed(msg.sender, itemId, amount);
    }


    /**
     * @dev Burns the specified amount of tokens from the sender's account.
     * The specified amount of tokens is destroyed and removed from circulation.
     */
    function burn(uint256 amount) public {
        _burn(msg.sender, amount);
    }

    /**
     * @dev Returns the balance of the specified account.
     * Overrides the balanceOf function in ERC20.sol.
     */
    function balanceOf(address account) public view override returns (uint256) {
        return super.balanceOf(account);
    }

    /**
     * @dev Set the redemption rate for a specific item.
     * Can only be called by the contract owner.
     */
    function setRedemptionRate(uint256 itemId, uint256 rate) public onlyOwner {
        _itemRedemptionRates[itemId] = rate;
    }

    /**
     * @dev Get the redemption rate for a specific item.
     */
    function getRedemptionRate(uint256 itemId) public view returns (uint256) {
        return _itemRedemptionRates[itemId];
    }
}