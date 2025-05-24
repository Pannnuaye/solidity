// test/OracleFuzz.t.sol
// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "web3bugs-102/oracle/ScalingPriceOracle.sol";

contract OracleFuzzTest is Test {
ScalingPriceOracle oracle;

```
function setUp() public {
    // Deploy with sample parameters; adjust as needed
    uint256 initialPrice = 1 ether;
    uint256 basisPoints = 10000;
    uint256 timeFrame = 1 days;
    oracle = new ScalingPriceOracle(initialPrice, basisPoints, timeFrame);
}

/// @notice Fuzz test ensuring price does not decrease over time
/// @param changeBP basis points change (1 to basisPoints)
/// @param deltaTime seconds to warp (1 to timeFrame)
function testFuzz_PriceCompounds(uint16 changeBP, uint256 deltaTime) public {
    // Bound inputs to valid ranges
    changeBP = bound(changeBP, 1, 10000);
    deltaTime = bound(deltaTime, 1, oracle.TIMEFRAME());

    // Record price before warp
    uint256 before = oracle.getCurrentOraclePrice();
    // Advance time
    vm.warp(block.timestamp + deltaTime);
    // Optionally trigger an update if needed:
    // oracle.updatePrice(changeBP);
    // Record price after time warp
    uint256 after = oracle.getCurrentOraclePrice();

    // Price should not decrease
    assertGe(after, before, "Price did not compound");
}
```

}
