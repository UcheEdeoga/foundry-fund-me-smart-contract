//SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import {Test, console} from "lib/forge-std/src/Test.sol";
import {FundMe} from "../../src/FundMe.sol";
import {DeployFundMe} from "../../script/DeployFundMe.s.sol";
import {FundFundMe,  WithdrawFundMe} from "../../script/Interactions.s.sol";


contract InteractionsTest is Test {

     FundMe fundMe;
     address USER = makeAddr("user");//Foundry cheat code to make a new address
     uint256 constant SEND_VALUE = 0.1 ether;
     uint256 constant STARTING_BALANCE = 100 ether; //We give the user we just creating some money as balance
     uint256 constant GAS_PRICE = 1;

    function setup() external {
        DeployFundMe deployFundMe = new DeployFundMe();
        fundMe = deployFundMe.run();
        vm.deal(USER, STARTING_BALANCE);
        
    }

    function testUserCanFundInteractions() public {
        FundFundMe fundFundMe = new FundFundMe();
        fundFundMe.fundFundMe(address(fundMe));

        WithdrawFundMe withdrawFundMe = new WithdrawFundMe();
        withdrawFundMe.withdrawFundMe(address(fundMe));

        assert(address(fundMe).balance == 0);
    } 
}