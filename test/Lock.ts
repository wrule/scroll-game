import { time, loadFixture } from "@nomicfoundation/hardhat-network-helpers";
import { anyValue } from "@nomicfoundation/hardhat-chai-matchers/withArgs";
import { expect } from "chai";
import { ethers } from "hardhat";

describe("Emoji", function () {
  // We define a fixture to reuse the same setup in every test.
  // We use loadFixture to run this setup once, snapshot that state,
  // and reset Hardhat Network to that snapshot in every test.
  it("jimao", async function () {
    const [owner] = await ethers.getSigners();
    console.log(owner.address);
    const EmojiFactory = await ethers.getContractFactory("Emoji", owner);
    const Emoji = await EmojiFactory.deploy();
    const tnx = await Emoji.mint({
      stringData: '😄',
      targetAddress: '',
      x: -1,
      y: -1,
      tokenURI: '',
    });
    const nfts = await Emoji.getNFTsInRectangle('-1', '-1', '1', '1');
    console.log(nfts);
    expect(1).to.equal(1);
  });
});
