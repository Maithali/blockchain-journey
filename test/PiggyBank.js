const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("PiggyBank", function () {
  let PiggyBank;
  let piggyBank;
  let owner;
  let otherAccount;

  beforeEach(async function () {
    // Get the signers
    [owner, otherAccount] = await ethers.getSigners();

    // Deploy the contract
    PiggyBank = await ethers.getContractFactory("PiggyBank");
    piggyBank = await PiggyBank.deploy();
    await piggyBank.waitForDeployment();
  });

  describe("Deployment", function () {
    it("Should set the correct owner", async function () {
      expect(await piggyBank.owner()).to.equal(owner.address);
    });
  });

  describe("Deposits", function () {
    it("Should accept direct ETH transfers via receive() and emit Deposit event", async function () {
      const depositAmount = ethers.parseEther("1.0");
      const contractAddress = await piggyBank.getAddress();

      // Send ETH directly to contract
      await expect(
        owner.sendTransaction({
          to: contractAddress,
          value: depositAmount,
        })
      )
        .to.emit(piggyBank, "Deposit")
        .withArgs(owner.address, depositAmount);

      // Check balance using the smart contract's checkBalance function
      expect(await piggyBank.checkBalance()).to.equal(depositAmount);
    });

    it("Should accept ETH via deposit() function and emit Deposit event", async function () {
      const depositAmount = ethers.parseEther("2.5");

      // Deposit ETH using deposit() function
      await expect(
        piggyBank.connect(otherAccount).deposit({ value: depositAmount })
      )
        .to.emit(piggyBank, "Deposit")
        .withArgs(otherAccount.address, depositAmount);

      expect(await piggyBank.checkBalance()).to.equal(depositAmount);
    });

    it("Should return correct balance from checkBalance()", async function () {
      const contractAddress = await piggyBank.getAddress();
      
      // Ensure initial balance is 0
      expect(await piggyBank.checkBalance()).to.equal(0);

      // Deposit 1 ETH from owner
      await owner.sendTransaction({
        to: contractAddress,
        value: ethers.parseEther("1.0"),
      });

      // Deposit 2 ETH from otherAccount
      await piggyBank.connect(otherAccount).deposit({ value: ethers.parseEther("2.0") });

      // Total balance should be 3 ETH
      expect(await piggyBank.checkBalance()).to.equal(ethers.parseEther("3.0"));
    });
  });

  describe("Withdrawals", function () {
    it("Should fail if a non-owner tries to withdraw", async function () {
      const contractAddress = await piggyBank.getAddress();
      
      // Deposit some ETH first
      await owner.sendTransaction({
        to: contractAddress,
        value: ethers.parseEther("1.0"),
      });

      // Try to withdraw as otherAccount
      await expect(
        piggyBank.connect(otherAccount).withdraw()
      ).to.be.revertedWith("Not the owner");
    });

    it("Should fail if the piggy bank is empty", async function () {
      // Try to withdraw with 0 balance
      await expect(piggyBank.withdraw()).to.be.revertedWith("Piggy bank is empty");
    });

    it("Should allow the owner to withdraw and transfer all funds to owner", async function () {
      const depositAmount = ethers.parseEther("5.0");
      const contractAddress = await piggyBank.getAddress();

      // Deposit 5 ETH
      await otherAccount.sendTransaction({
        to: contractAddress,
        value: depositAmount,
      });

      // Track owner balance before withdrawal
      const ownerBalanceBefore = await ethers.provider.getBalance(owner.address);

      // Withdraw and get transaction details to calculate gas spent
      const tx = await piggyBank.withdraw();
      const receipt = await tx.wait();
      
      // Calculate gas cost: gasUsed * gasPrice
      const gasSpent = receipt.gasUsed * receipt.gasPrice;

      // Verify contract balance is reset to 0
      expect(await piggyBank.checkBalance()).to.equal(0);

      // Verify owner received the funds (minus gas costs)
      const ownerBalanceAfter = await ethers.provider.getBalance(owner.address);
      expect(ownerBalanceAfter).to.equal(ownerBalanceBefore + depositAmount - gasSpent);
    });

    it("Should emit Withdraw event on successful withdrawal", async function () {
      const depositAmount = ethers.parseEther("3.0");
      const contractAddress = await piggyBank.getAddress();

      // Deposit 3 ETH
      await otherAccount.sendTransaction({
        to: contractAddress,
        value: depositAmount,
      });

      // Withdraw and expect event
      await expect(piggyBank.withdraw())
        .to.emit(piggyBank, "Withdraw")
        .withArgs(depositAmount);
    });
  });
});
