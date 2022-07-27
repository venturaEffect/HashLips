// SPDX-License-Identifier: MIT

pragma solidity^0.8.0;

contract MyVariables {
    uint256 number = 20; //state variable
    bool paused = true; //state variable
    uint256 internal time = block.timestamp; // state variable saving a global variable
    uint256 public msgValue = msg.value;
    uint public gasPrice = tx.gasprice;

    function myFunc() public view returns(address) {
        /// uint localNumber = 20; //local variable
        /// bool localPaused = true; //local variable   
        address theSenderAddress = msg.sender;
        return theSenderAddress;

    }

}

contract INeedVariables is MyVariables {
    uint public newTime = uint(time);

}