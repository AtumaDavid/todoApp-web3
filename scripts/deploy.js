// const hre = require("hardhat");

// async function main() {
//   const ToDoList = await hre.ethers.getContractFactory("ToDoList");
//   const toDoList = await ToDoList.deploy();

//   //   await toDoList.deployed();

//   console.log("Lock with 1 ETH deployed to:", toDoList.address);

//   console.log(toDoList);
// }

// main().catch((error) => {
//   console.error(error);
//   process.exitCode = 1;
// });

const hre = require("hardhat");

async function main() {
  // Get the contract factory
  const ToDoList = await hre.ethers.getContractFactory("ToDoList");

  // Deploy the contract
  console.log("Deploying ToDoList...");
  const todoList = await ToDoList.deploy();

  // Wait for the deployment transaction to be mined
  await todoList.waitForDeployment();

  console.log("ToDoList deployed to:", await todoList.getAddress());
}

// Run the deployment
main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
