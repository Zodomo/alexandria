// SPDX-License-Identifier: AGPL-3.0
pragma solidity ^0.8.20;

import "solmate/test/utils/DSTestPlus.sol";
import "../src/alexandria.sol";

contract alexandriaTest is DSTestPlus {
    alexandria public template;

    function setUp() public {
        template = new alexandria("Test", "TEST");
    }
}
