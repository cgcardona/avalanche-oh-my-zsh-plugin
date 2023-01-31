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
