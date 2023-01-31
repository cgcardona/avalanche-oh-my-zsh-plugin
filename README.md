# Avalanche oh-my-zsh Plugin

The `avalanche` plugin provides many useful [functions](#functions).

To use it, add `avalanche` to the plugins array in your zshrc file:

```zsh
plugins=(... avalanche)
```

## Aliases

## Functions

| Command                | Description                                                                                              |
| :--------------------- | :------------------------------------------------------------------------------------------------------- |
| `setAvalancheEnvironment <local|fuji|mainnet>`  | Sets the public API url per the environment remote                                                 |
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
