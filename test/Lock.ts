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
    const EmojiFactory = await ethers.getContractFactory("Emoji");
    const Emoji = await EmojiFactory.deploy();
    const a = await Emoji.mint(owner.address, '', '😄', owner.address, '0', '0');
    // console.log(a);
    const nft = await Emoji.getNFTsInRectangle('-1', '-1', '1', '1');
    console.log(nft);
    expect(1).to.equal(1);
  });
});
