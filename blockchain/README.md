# Combs Blockchain

This blockchain project implements a custom ecosystem with:

- CombsToken: ERC20 token tradeable to USD (simplified).
- SmartWallet: Basic smart wallet for the owner.
- Banking: Simple banking contract for deposits and withdrawals.

Licensed under Combs Proprietary License.

## Setup

1. Install dependencies: `npm install`
2. Compile: `npx hardhat compile`
3. Deploy: `npx hardhat run scripts/deploy.js --network base`

## Features

- Token trading to USD via tradeToUSD function.
- Smart wallet execution.
- Banking deposits and transfers.

Integrated with Maker protocol concepts for stability.