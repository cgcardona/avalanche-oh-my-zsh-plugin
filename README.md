# Avalanche oh-my-zsh Plugin

The `avalanche` plugin provides many useful [functions](#functions).

To use it, add `avalanche` to the plugins array in your zshrc file:

```zsh
plugins=(... avalanche)
```

## Aliases

## Functions

### Custom

| Command                | Description                                                                                              |
| :--------------------- | :------------------------------------------------------------------------------------------------------- |
| `setAvalancheEnvironment <local|fuji|mainnet>`  | Sets the public API url per the environment remote                                                 |

### Admin

| Command                | Description                                                                                              |
| :--------------------- | :------------------------------------------------------------------------------------------------------- |
| `setAlias <newAlias> <endpoint>`         | Assign an API endpoint an alias, a different endpoint for the API.|
| `aliasChain <chain> <newAlias>`  | Give a blockchain an alias, a different name that can be used any place the blockchain’s ID is used.|
| `getChainAliases <chain>` | Returns the aliases of the chain |
| `getLoggerLevel <loggerName>`        | Returns log and display levels of loggers.|
| `loadVMs`     | Dynamically loads any virtual machines installed on the node as plugins. |
| `lockProfile`     | Writes a profile of mutex statistics to lock.profile. |
| `memoryProfile`     | Writes a memory profile of the to mem.profile. |
| `setLoggerLevel <loggerName> <logLevel> <displayLevel>`     | Sets log and display levels of loggers. |
| `startCPUProfiler`     | Start profiling the CPU utilization of the node.|
| `stopCPUProfiler`     | Stop the CPU profile that was previously started. |

### Auth

| Command                | Description                                                                                              |
| :--------------------- | :------------------------------------------------------------------------------------------------------- |
| `newToken <password> <endpoints>`         | Creates a new authorization token that grants access to one or more API endpoints.|
| `revokeToken <password> <token>`         | Revoke a previously generated token.|
| `changePassword <oldPassword> <newPassword>`         | Change this node’s authorization token password.|

### Health

| Command                | Description                                                                                              |
| :--------------------- | :------------------------------------------------------------------------------------------------------- |
| `health`         | The node runs a set of health checks every 30 seconds, including a health check for each chain. |

### Index

| Command                | Description                                                                                              |
| :--------------------- | :------------------------------------------------------------------------------------------------------- |
| `getLastAccepted <encoding>`         | Get the most recently accepted container. |
| `getContainerByIndex <index> <encoding>`         | Get container by index. |
| `getContainerByID <id> <encoding>`         | Get container by ID. |
| `getContainerRange <startIndex> <numToFetch> <encoding>`         | Returns containers with indices |
| `getIndex <id> <encoding>`         | Get a container's index. |
| `isAccepted <id> <encoding>`         | Returns true if the container is in this index. |

### Info

| Command                | Description                                                                                              |
| :--------------------- | :------------------------------------------------------------------------------------------------------- |
| `getBlockchainID <alias>`     | Given a blockchain’s alias, get its ID.  |
| `getNetworkID`     | Get the ID of the network this node is participating in. |
| `getNetworkName`     | Get the name of the network this node is participating in. |
| `getNodeID`     | Get the ID of this node. |
| `getNodeIP`     | Get the IP of this node. |
| `getNodeVersion`     | Get the version of this node. |
| `getVMs`     | Get the virtual machines installed on this node. |
| `isBootstrapped <chain>`     | Check whether a given chain is done bootstrapping |
| `peers <nodeIDs>`     | Get a description of peer connections. |
| `getTxFee`     | Get the fees of the network. |
| `uptime`     | Returns the network's observed uptime of this node. |

### IPC

| Command                | Description                                                                                              |
| :--------------------- | :------------------------------------------------------------------------------------------------------- |
| `publishBlockchain <blockchainID>`| Register a blockchain so it publishes accepted vertices to a Unix domain socket. |
| `unpublishBlockchain <blockchainID>`| Deregister a blockchain so that it no longer publishes to a Unix domain socket. |

### Metrics

| Command                | Description                                                                                              |
| :--------------------- | :------------------------------------------------------------------------------------------------------- |
| `metrics`| To get the node metrics |

### Platform

| Command                | Description                                                                                              |
| :--------------------- | :------------------------------------------------------------------------------------------------------- |
| `platform.getBalance [<addresses>]`| Get the balance of AVAX controlled by a given address. |
| `platform.getBlock <blockID> <encoding>`| Get a block by its ID. |
| `platform.getBlockchains`| Get all the blockchains that exist (excluding the P-Chain). |
| `platform.getBlockchainStatus <blockchainID>`| Get the status of a blockchain. |
| `platform.getCurrentSupply <subnetID>`| Returns an upper bound on amount of tokens that exist that can stake the requested Subnet. |
| `platform.getCurrentValidators <subnetID> [<nodeIDs>]`| List the current validators of the given Subnet. |
| `platform.getHeight`| Returns the height of the last accepted block. |
| `platform.getMaxStakeAmount <subnetID> <nodeID> <startTime> <endTime>`| Returns the maximum amount of nAVAX staking to the named node during a particular time period. |
| `platform.getMinStake <subnetID>`| Get the minimum amount of tokens required to validate the requested Subnet and the minimum amount of tokens that can be delegated. |
| `platform.getPendingValidators <subnetID> [<nodeIDs>]`| List the validators in the pending validator set of the specified Subnet. |
| `platform.getRewardUTXOs <txID> <encoding>`| Returns the UTXOs that were rewarded after the provided transaction's staking or delegation period ended. |
| `platform.getStakingAssetID <subnetID>`| Retrieve an assetID for a Subnet’s staking asset. |
| `platform.getSubnets [<ids>]`| Get info about the Subnets. |
| `platform.getStake <ids>`| Get the amount of nAVAX staked by a set of addresses. |
| `platform.getTimestamp`| Get the current P-Chain timestamp. |
| `platform.getTotalStake <subnetID>`| Get the total amount of tokens staked on the requested Subnet. |
| `platform.getTx <txID> <encoding>`| Gets a transaction by its ID. |
| `platform.getTxStatus <txID>`| Gets a transaction’s status by its ID.  |
| `platform.getUTXOs <addresses> <limit> <encoding>`| Gets the UTXOs that reference a given set of addresses. |
| `platform.getValidatorsAt <height> <subnetID>`| Get the validators and their weights of a Subnet or the Primary Network at a given P-Chain height. |
| `platform.issueTx <tx> <encoding>`| Issue a transaction to the Platform Chain. |
| `platform.sampleValidators <tx> <encoding>`| Sample validators from the specified Subnet. |
| `platform.validatedBy <blockchainID>`| Get the Subnet that validates a given blockchain. |
| `platform.validates <subnetID>`| Get the IDs of the blockchains a Subnet validates. |
