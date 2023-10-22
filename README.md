##Description
This is a smart contract written in foundry which enable you to import a NFT to your account through the forge commands. There is a src folder where 2 contracts are written, one for BasicNFT and the other for a DynamicNFT(it changes as per your wish). The scripts for interacting and deploying these contracts are also present in the Script folder. Further the tests for the contracts are in test folder.

I have used libraries such as openzeppelin and foundry devOpsTools along with the forge-std library for this project.

openzeppelin is used for getting the ERC721 contract which I have inherited in my projects.
devOpsTools is used for getting the most recently deployed contract.

Refer to Makefile for further assistance.

