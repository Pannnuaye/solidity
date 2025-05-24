// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "forge-std/Test.sol";

contract SmokeTest is Test {
    function testCompileOnly() public {
        // 只要能编译整个 src/ 就算通过
        assert(true);
    }
}
