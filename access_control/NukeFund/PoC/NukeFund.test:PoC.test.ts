it('should revert to nuke a token', async function () {
    const tokenId = 1;

    // Mint a token
    await nft.connect(owner).mintToken(merkleInfo.whitelist[0].proof, {
    value: ethers.parseEther('1'),
    });

    // Send some funds to the contract
    await user1.sendTransaction({
    to: await nukeFund.getAddress(),
    value: ethers.parseEther('1'),
    });

    const prevNukeFundBal = await nukeFund.getFundBalance();
    // Ensure the token can be nuked
    expect(await nukeFund.canTokenBeNuked(tokenId)).to.be.true;

    const prevUserEthBalance = await ethers.provider.getBalance(
    await owner.getAddress()
    );
    // await nft.connect(owner).approve(await nukeFund.getAddress(), tokenId);
    await nft.connect(owner).approve(user1, tokenId);
    await nft.connect(owner).setApprovalForAll(await nukeFund.getAddress(), true);

    const finalNukeFactor = await nukeFund.calculateNukeFactor(tokenId);
    const fund = await nukeFund.getFundBalance();

    // await expect(nukeFund.connect(owner).nuke(tokenId))
    await expect(nukeFund.connect(user1).nuke(tokenId)).to.be.revertedWith("Contract must be approved to transfer the NFT.");
});