# Building on Avalanche - ETH + AVAX Projects2 Documentation

# Description:
This is the second project in AVAX-Intermediate, in this project I am tasked to create a simple contract with 2-3 functions. Then show the values of those functions in frontend of the application.

# Requirements:
1. MetaMask extension installed in your web browser.

#Getting Started:

1. Clone the Repository:
   Download the entire repository from GitHub to access all the project contents.

2. Install Dependencies:
   In the project directory, open your terminal or command prompt and run the following command to install the required dependencies using npm:

   ```
   npm install
   ```

3. Start Local Hardhat Node:
   After installing the dependencies, run the following command to start the local Hardhat node:

   ```
   npx hardhat node
   ```

4. Deploy the Contract:
   Open a second terminal and deploy the contract on the local Hardhat node using the following command:

   ```
   npx hardhat run scripts/deploy.js --network localhost
   ```

5. Configure MetaMask:
   - Add Hardhat Network: In MetaMask, add a new network with the following settings:
     - Network Name: Hardhat
     - New RPC URL: http://localhost:8545
     - Chain ID: 1337

   - Import Account: In the first terminal where the Hardhat node is running, copy any of the private keys (preferably the first one) and import it into MetaMask.

6. Start the Frontend:
   In the second terminal, run the following command to start the application frontend in development mode:

   ```
   npm start
   ```

7. View the Application:
   Open http://localhost:3000 in your web browser to view the application. You should see the values of the functions displayed on the frontend.

Additional Commands:

- Get Help: To get help or view available Hardhat commands, run:

  ```
  npx hardhat help
  ```

- Test the Contract: To run tests for the smart contract, use the following command:

  ```
  npx hardhat test
  ```

# Author:
[[Samaila Anthony Malima](https://github.com/samailamalima)] 

# License
This project is licensed under the MIT License.
