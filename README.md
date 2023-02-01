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
