// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

//Fund
//Withdraw

import {Script, console} from "forge-std/Script.sol";
import {DevOpsTools} from "../lib/foundry-devops/src/DevOpsTools.sol";
import {FundMe} from "../src/FundMe.sol";

contract FundFundMe is Script {
    uint256 constant SEND_VALUE = 0.01 ether; 
    function f_FundFundMe (address mostRecentlyDeployed) public {
        vm.startBroadcast();
        FundMe(payable (mostRecentlyDeployed)).fund{value: SEND_VALUE}();
        vm.stopBroadcast();
        console.log("Funded FundMe with %s", SEND_VALUE);
    }
    function run() external {
        address mostRecentlyDeployed = DevOpsTools.get_most_recent_deployment("FundMe", block.chainid);
        vm.startBroadcast();
        f_FundFundMe(mostRecentlyDeployed);
        vm.stopBroadcast();
    }
}

contract WithdrawFundMe is Script {
    function w_WithdrawFundMe (address mostRecentlyDeployed) public { 
        vm.startBroadcast();
        FundMe(payable (mostRecentlyDeployed)).withdraw();
        vm.stopBroadcast();
    }
    function run() external {
        address mostRecentlyDeployed = DevOpsTools.get_most_recent_deployment("FundMe", block.chainid);
        vm.startBroadcast();
        w_WithdrawFundMe(mostRecentlyDeployed);
        vm.stopBroadcast();
    }
}