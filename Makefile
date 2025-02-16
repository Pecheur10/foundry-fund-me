-include .env

.PHONY: all test clean deploy fund help install snapshot format anvil zktest

build:; forge build

deploy-sepolia:; forge script  script/DeployFundMe.s.sol:DeployFundMe --rpc-url $(SEPOLIA_RPC_URL) --private-key $(PRIVATE_KEY) --broadcast --verify --etherscan-api-key $(ETHERSCAN_API_KEY) -vvvv

all: clean remove install update build

# Clean the repo
clean  :; forge clean

# Remove modules
remove :; rm -rf .gitmodules && rm -rf .git/modules/* && rm -rf lib && touch .gitmodules && git add . && git commit -m "modules"

# Update Dependencies
update:; forge update

build:; forge build

zkbuild :; forge build --zksync

test :; forge test

zktest :; foundryup-zksync && forge test --zksync && foundryup

snapshot :; forge snapshot

format :; forge fmt

anvil :; anvil -m 'test test test test test test test test test test test junk' --steps-tracing --block-time 1

zk-anvil :; npx zksync-cli dev start

help:
    @echo "Available targets:"
    @echo "  all        - clean, remove, install, update, build"
    @echo "  clean      - clean the repo"
    @echo "  remove     - remove modules"
    @echo "  install    - install dependencies"
    @echo "  update     - update dependencies"
    @echo "  build      - build the project"
    @echo "  test       - run tests"
    @echo "  snapshot   - create a snapshot"
    @echo "  format     - format the code"
    @echo "  anvil      - run anvil"
    @echo "  zk-anvil   - run zksync anvil"
    @echo "  zkbuild    - build the project with zksync"
    @echo "  zktest     - run tests with zksync"
    @echo "  deploy-sepolia - deploy to sepolia"
    @echo "  fund       - fund the contract"
    @echo "  withdraw   - withdraw from the contract"

SENDER_ADDRESS := <sender's address>
 
fund:
	@forge script script/Interactions.s.sol:FundFundMe --sender $(SENDER_ADDRESS) $(NETWORK_ARGS)

withdraw:
	@forge script script/Interactions.s.sol:WithdrawFundMe --sender $(SENDER_ADDRESS) $(NETWORK_ARGS)