// SPDX-License-Identifier: AGPL-3.0
pragma solidity ^0.8.20;

import "solmate/test/utils/DSTestPlus.sol";
import "solady/src/utils/LibString.sol";
import "forge-std/console2.sol";
import "../src/alexandria.sol";

contract alexandriaTest is DSTestPlus {
    alexandria public book;

    function setUp() public {
        book = new alexandria("Test", "TEST", 100, 0);
    }

    function testWriteAndRead() public {
        address chapter = book.write("test");
        require(chapter != address(0), "SSTORE2 write error");
        book.mint{ value: 0 }(address(this), 1);
        string memory text = book.tokenURI(1);
        require(keccak256(abi.encodePacked("test")) == keccak256(abi.encodePacked(text)), "tokenURI error");
    }
}
