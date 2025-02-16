// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

// 1. Deploy mock when we are on our local anvil chain. 
// 2. Keep trakc of contract addresses across differents chain.


import {Script} from "forge-std/Script.sol";
import {MockV3Aggregator} from "../test/mocks/MockV3Aggregator.sol";

contract HelperConfig is Script {
    // If we are on our local anvil chain, we will deploy mock contracts.
    // If we are on the mainnet, we will deploy the real contracts.
    // Otherwise, grab the existing address from the live network.
    // This is a simple way to manage contract addresses across different networks.
    NetworkConfig public activeNetworkConfig;

    uint8 public constant DECIMALS = 8;
    int256 public constant INITIAL_ANSWER = 2000e8;

    struct NetworkConfig {
        address priceFeed; // ETH/USD price feed address
    }

    constructor () {
        if (block.chainid == 11155111){
           // Set the active network config
            activeNetworkConfig = getSepoliaEthConfig();
        }
        else if (block.chainid == 1){
            activeNetworkConfig = getMainetEthConfig();
        }
        else {
            activeNetworkConfig = getOrCreateAnvilEthConfig();
        }

    }

    function getSepoliaEthConfig() public pure returns(NetworkConfig memory) {
        //price feed address
        NetworkConfig memory sepoliaConfig = NetworkConfig({priceFeed: 0x694AA1769357215DE4FAC081bf1f309aDC325306});
        return sepoliaConfig;
    }

    function getMainetEthConfig() public pure returns(NetworkConfig memory) {
        //price feed address
        NetworkConfig memory ethConfig = NetworkConfig({priceFeed: 0x5f4eC3Df9cbd43714FE2740f5E3616155c5b8419});
        return ethConfig;
    }

    function getOrCreateAnvilEthConfig() public returns(NetworkConfig memory) {
        if (activeNetworkConfig.priceFeed != address(0)){
            return activeNetworkConfig;
        }

        // 1. Deploy the Mock
        // 2. Return the address of the Mock
        vm.startBroadcast();
        MockV3Aggregator mockPriceFeed = new MockV3Aggregator(DECIMALS, INITIAL_ANSWER);
        vm.stopBroadcast();

        NetworkConfig memory anvilConfig = NetworkConfig({priceFeed: address(mockPriceFeed)});
        return anvilConfig;
    }
}