// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;


/// @title The best smart contract
/// @author HashLips
/// @dev Please use this in this or that way
contract MyContract {
    string public name = "Osco";

    /// @notice This function changes the name of the name variable
    function updateName(string memory _name) public {
        name = _name;
    }
}