// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract MyArray {
    uint256[] public myArray;

    function setArray(uint256 _num) public {
        myArray.push(_num);
    }

    function getArray() public view returns(uint256[] memory) {
        return myArray;
    }
}