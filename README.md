# Foundry Fund Me

This project is part of the Cyfrin Solidity Course.
It's my very first Solidity project—a stepping stone in what I believe will be a long and exciting journey in blockchain development. I am motivated to learn more and build even more advanced decentralized applications in the future.

## Getting Started

### Requirements

Install git and verify with git --version

Install foundry and check with forge --version

### Quickstart
```shell
$ git clone https://github.com/Cyfrin/foundry-fund-me-cu
$ cd foundry-fund-me-cu
$ make
```
### Optional: Gitpod

For an online development environment, use Gitpod.

### Usage

## Deploying
```shell
$ forge script script/DeployFundMe.s.sol
```
## Testing
```shell
$ forge test
```
## To test with Sepolia fork:
```shell
$ forge test --fork-url $SEPOLIA_RPC_URL
```
## Test Coverage
```shell
$ forge coverage
```
## Working with zkSync Locally

### Additional Requirements

* Install foundry-zksync

* Install npx & npm

* Install Docker and ensure the daemon is running

### Setup Local zkSync Node
```shell
$ npx zksync-cli dev config
```
### Select In memory node, then run:
```shell
$ npx zksync-cli dev start
```
### Deploy to zkSync Local Node
```shell
$ make deploy-zk
```
## Deploying to a Testnet or Mainnet

1. Set up environment variables (SEPOLIA_RPC_URL, PRIVATE_KEY, ETHERSCAN_API_KEY in .env)

2. Obtain testnet ETH from faucets.chain.link

3. Deploy the contract:

```shell
$ forge script script/DeployFundMe.s.sol --rpc-url $SEPOLIA_RPC_URL --private-key $PRIVATE_KEY --broadcast --verify --etherscan-api-key $ETHERSCAN_API_KEY
```
### Running Scripts
```shell
$ cast send <FUNDME_CONTRACT_ADDRESS> "fund()" --value 0.1ether --private-key <PRIVATE_KEY>
```
### Withdraw funds:
```shell
$ cast send <FUNDME_CONTRACT_ADDRESS> "withdraw()" --private-key <PRIVATE_KEY>
```
### Estimate Gas Usage
```shell
$ forge snapshot
```
### Formatting Code

```shell
$ forge fmt
```

For further details, refer to the official documentation. Happy coding!

______________________

1. Proper README
2. Integration test
    1. Put a MAKEFILE so we run these scripts easier.
3. Programatic verification
4. Push to Github

_______________________