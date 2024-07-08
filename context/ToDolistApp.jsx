import React from "react";
import { toDoListABI, toDoListAddress } from "./constants";
import { ethers } from "hardhat";

const fetchContract = (signerOrProvider) =>
  ethers.Contract(toDoListAddress, toDoListABI, signerOrProvider);

export const ToDoListContext = React.createContext();

export const ToDoListProvider = ({ children }) => {
  return (
    <ToDoListContext.Provider value={{}}>{children}</ToDoListContext.Provider>
  );
};

export default function ToDolistApp() {
  return <div>Todo list app</div>;
}
