// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

contract ToDoList {
    uint256 public _idUser; // Public variable to store the number of users
    address public ownerOfContract; // Public variable to store the owner of the contract

    address[] public creators; // Public array to store addresses of creators
    string[] public message; // Public array to store messages created
    uint[] public messageId; // Public array to store message IDs

    struct ToDoListApp {
        address account; // Address of the user
        uint256 userId; // Unique ID for each user
        string message; // Message associated with the user
        bool completed; // Status of completion for the task
    }

    // Event emitted when a new to-do item is created or its completion status changes
    event ToDoEvent(
        address indexed account, 
        uint256 indexed userId,
        string message,
        bool completed
    );

    mapping (address => ToDoListApp) public toDolistApps; // Mapping to store ToDoListApp structs by address

    constructor() {
        ownerOfContract = msg.sender; // Set the owner of the contract to the deployer's address
    }

    function inc() internal {
        _idUser++; // Internal function to increment the user ID
    }


// Function to create a new to-do item
    function createList(string calldata _message) external {
        inc(); // Increment the user ID

        uint256 idNumber = _idUser; // Get the current user ID
        ToDoListApp storage toDo = toDolistApps[msg.sender]; // Access the ToDoListApp struct for the current user

        toDo.account = msg.sender; // Set the user's address
        toDo.message = _message; // Set the message associated with the user
        toDo.completed = false; // Initialize completion status as false
        toDo.userId = idNumber; // Set the user ID

        creators.push(msg.sender); // Add the creator's address to the creators array
        message.push(_message); // Add the message to the message array
        messageId.push(idNumber); // Add the message ID to the messageId array

        emit ToDoEvent(msg.sender, toDo.userId, _message, toDo.completed); // Emit an event indicating a new to-do item creation
    }

 // Function to retrieve data associated with a creator
    function getCreatorData(address _address) public view returns (address, uint256, string memory, bool) {
        ToDoListApp memory singleUserData = toDolistApps[_address]; // Retrieve ToDoListApp struct for the given address

        return (
            singleUserData.account,
            singleUserData.userId,
            singleUserData.message,
            singleUserData.completed
        ); // Return the creator's address, user ID, message, and completion status
    }


    // Function to get all addresses of creators
    function getAddress() external view returns (address[] memory) {
        return creators;
    }

    // Function to get all messages created by creators
    function getMessage() external view returns (string[]  memory) {
        return message;
    }

    // Function to toggle the completion status of a to-do item for a creator
    function toggle(address _creator) public {
        ToDoListApp storage singleUserData = toDolistApps[_creator]; // Access ToDoListApp struct for the specified creator
        singleUserData.completed = !singleUserData.completed; // Toggle the completion status
    }
}