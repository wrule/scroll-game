import { ethers } from "hardhat";

async function main() {
  const EmojiFactory = await ethers.getContractFactory("Emoji");
  const Emoji = await EmojiFactory.deploy();
  await Emoji.deployed();
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
