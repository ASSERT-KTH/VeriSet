function testTeamRewardIsLockedInUpkeep() public {
    uint releasableAmount = teamVestingWallet.releasable(address(salt));
    uint upKeepBalance = salt.balanceOf(address(upkeep));
    uint mainWalletBalance = salt.balanceOf(address(managedTeamWallet.mainWallet()));
    //@audit-info a certain amount of SALT is releasable
    assertTrue(releasableAmount != 0);
    //@audit-info there is no SALT in upkeep
    assertEq(upKeepBalance, 0);
    //@audit-info there is no SALT in mainWallet
    assertEq(mainWalletBalance, 0);
    //@audit-info call release() before performUpkeep()
    teamVestingWallet.release(address(salt));
    upkeep.performUpkeep();
    
    upKeepBalance = salt.balanceOf(address(upkeep));
    mainWalletBalance = salt.balanceOf(address(managedTeamWallet.mainWallet()));
    //@audit-info all released SALT is locked in upKeep
    assertEq(upKeepBalance, releasableAmount);
    //@audit-info development team receive nothing
    assertEq(mainWalletBalance, 0);
}