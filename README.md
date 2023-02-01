# Avalanche oh-my-zsh Plugin

<img alt="Avalanche Logo" width="300px" src="assets/powered-by-avalanche.png">

[Avalanche](https://docs.avax.network) is an open-source platform for launching decentralized applications and enterprise blockchain deployments in one interoperable, highly scalable ecosystem. [Oh My Zsh](https://ohmyz.sh) is a delightful, open source, community-driven framework for managing your Zsh configuration. This oh-my-zsh plugin brings all the power of Avalanche to your terminal!

Supported APIs

- [P-Chain](#p-chain)
- [C-Chain](#c-chain)
- [X-Chain](#x-chain)
- [Admin](#admin)
- [Auth](#auth)
- [Health](#health)
- [Index](#index)
- [Info](#info)
- [IPC](#ipc)
- [Metrics](#metrics)

## Config

To use it, add `avalanche` to the plugins array in your zshrc file:

```zsh
plugins=(... avalanche)
```

Change the API endpoint for the appropriate network by passing `local`, `fuji`, or `mainnet` into `setAvalancheEnvironmet`

```zsh
# set to a local network
setAvalancheEnvironment local
echo $AVALANCHE_NETWORK && echo $AVALANCHE_PUBLIC_API
local
http://127.0.0.1:9650/

# set to fuji testnet
setAvalancheEnvironment fuji
echo $AVALANCHE_NETWORK && echo $AVALANCHE_PUBLIC_API
fuji
https://api.avax-test.network/

# set to mainnet
setAvalancheEnvironment mainnet
echo $AVALANCHE_NETWORK && echo $AVALANCHE_PUBLIC_API
mainnet
https://api.avax.network/
```

## Examples

Get and set chain alias

```zsh
admin.aliasChain qzfF3A11KzpcHkkqznEyQgupQrCNS6WV6fTUTwZpEKqhj1QE7 myBlockchainAlias
{
  "jsonrpc":"2.0",
  "result":{},
  "id":1
}

admin.getChainAliases qzfF3A11KzpcHkkqznEyQgupQrCNS6WV6fTUTwZpEKqhj1QE7
{
  "jsonrpc": "2.0",
  "result": {
    "aliases": [
      "X",
      "avm",
      "qzfF3A11KzpcHkkqznEyQgupQrCNS6WV6fTUTwZpEKqhj1QE7",
      "myBlockchainAlias"
    ]
  },
  "id": 1
}
```

Get the full node's peers

```zsh
info.peers

info.peers
{
  "jsonrpc": "2.0",
  "result": {
    "numPeers": "4",
    "peers": [
      {
        "ip": "[::1]:50452",
        "publicIP": "127.0.0.1:9657",
        "nodeID": "NodeID-GWPcbFJZFfZreETSoWjPimr846mXEKCtu",
        "version": "avalanche/1.9.7",
        "lastSent": "2023-01-31T19:55:03-08:00",
        "lastReceived": "2023-01-31T19:55:03-08:00",
        "observedUptime": "99",
        "observedSubnetUptimes": {
          "2TGBXcnwx5PqiXWiqxAKUaNSqDguXNh1mxnp82jui68hxJSZAx": "100",
          "2hGaRX3FE1F6N6p5GGvgcPhGAzKqU1EU2mGLhmAm9gJP4AUMWL": "100",
          "2hi9bT3cmirfQtcxa9TXfmuaqMSN1SBPp2UasY5syR29JaeVhu": "100",
          "2iGRatsMmwDFNHxH5kXP298K8DqFUmgkeP1uRXcAvHjaka5nDJ": "100",
          "2kAUpkozB41u39QeYKTUre9hPUNH2mxHmebKEBZxwSDJrkHr2f": "100",
          "2w44EFw47yxdiYzuT9ChtsPAaQXmVv733JzPdx13E5s75SMobc": "100",
          "MjcAMGb2GtwAqEUHTkMzWrZyEptnQYf2xD5BiRweaDkwSPu23": "100",
          "hWwsQTt1mmgdvpP7cMqHpjALwAqm6dTukLsxeAfpDD8t2hEUg": "100",
          "p433wpuXyJiDhyazPYyZMJeaoPSW76CBZ2x7wrVPLgvokotXz": "100",
          "zMwcj6UBeGXpXpu4igMSgZAJjbJbHF7qwibLSrvcTVGGysAjz": "100"
        },
        "trackedSubnets": [
          "hWwsQTt1mmgdvpP7cMqHpjALwAqm6dTukLsxeAfpDD8t2hEUg",
          "MjcAMGb2GtwAqEUHTkMzWrZyEptnQYf2xD5BiRweaDkwSPu23",
          "p433wpuXyJiDhyazPYyZMJeaoPSW76CBZ2x7wrVPLgvokotXz",
          "2w44EFw47yxdiYzuT9ChtsPAaQXmVv733JzPdx13E5s75SMobc",
          "2kAUpkozB41u39QeYKTUre9hPUNH2mxHmebKEBZxwSDJrkHr2f",
          "2hGaRX3FE1F6N6p5GGvgcPhGAzKqU1EU2mGLhmAm9gJP4AUMWL",
          "2TGBXcnwx5PqiXWiqxAKUaNSqDguXNh1mxnp82jui68hxJSZAx",
          "zMwcj6UBeGXpXpu4igMSgZAJjbJbHF7qwibLSrvcTVGGysAjz",
          "2hi9bT3cmirfQtcxa9TXfmuaqMSN1SBPp2UasY5syR29JaeVhu",
          "2iGRatsMmwDFNHxH5kXP298K8DqFUmgkeP1uRXcAvHjaka5nDJ"
        ],
        "benched": []
      },
      ...
    ]
  }
}
```

Measure your node's health

```zsh
avalanche.health

{
  "jsonrpc": "2.0",
  "result": {
    "checks": {
      "22X2bbFdnpEQKi4XvH65N4mJJiiBrP67GnqUEU4gefFAEMUkf5": {
        "message": {
          "consensus": {
            "longestRunningBlock": "0s",
            "outstandingBlocks": 0
          },
          "vm": {
            "database": {
              "v1.4.5": null
            },
            "health": null
          }
        },
        "timestamp": "2023-01-31T19:59:27.492906-08:00",
        "duration": 787634
      },
      "C": {
        "message": {
          "consensus": {
            "longestRunningBlock": "0s",
            "outstandingBlocks": 0
          },
          "vm": null
        },
        "timestamp": "2023-01-31T19:59:27.49212-08:00",
        "duration": 50490
      },
      "P": {
        "message": {
          "consensus": {
            "longestRunningBlock": "0s",
            "outstandingBlocks": 0
          },
          "vm": {
            "2TGBXcnwx5PqiXWiqxAKUaNSqDguXNh1mxnp82jui68hxJSZAx-percentConnected": 1,
            "2hGaRX3FE1F6N6p5GGvgcPhGAzKqU1EU2mGLhmAm9gJP4AUMWL-percentConnected": 1,
            "2hi9bT3cmirfQtcxa9TXfmuaqMSN1SBPp2UasY5syR29JaeVhu-percentConnected": 1,
            "2iGRatsMmwDFNHxH5kXP298K8DqFUmgkeP1uRXcAvHjaka5nDJ-percentConnected": 1,
            "2kAUpkozB41u39QeYKTUre9hPUNH2mxHmebKEBZxwSDJrkHr2f-percentConnected": 1,
            "2w44EFw47yxdiYzuT9ChtsPAaQXmVv733JzPdx13E5s75SMobc-percentConnected": 1,
            "MjcAMGb2GtwAqEUHTkMzWrZyEptnQYf2xD5BiRweaDkwSPu23-percentConnected": 1,
            "hWwsQTt1mmgdvpP7cMqHpjALwAqm6dTukLsxeAfpDD8t2hEUg-percentConnected": 1,
            "p433wpuXyJiDhyazPYyZMJeaoPSW76CBZ2x7wrVPLgvokotXz-percentConnected": 1,
            "primary-percentConnected": 1,
            "zMwcj6UBeGXpXpu4igMSgZAJjbJbHF7qwibLSrvcTVGGysAjz-percentConnected": 1
          }
        },
        "timestamp": "2023-01-31T19:59:27.492418-08:00",
        "duration": 243582
      },
      ...
    }
  }
}
```

Get the last accepted X-Chain vertex

```zsh
index.getLastAccepted hex

{
  "jsonrpc": "2.0",
  "result": {
    "id": "2SjjBSqqLy6uyn789B4f8EhhJ38BUR5Gwe9xEqWQ5mj85wKwjK",
    "bytes": "0x000000000000000005396f3f45c17a15b4ad36f65ebcea5df66089e8495bb7e59cd25411cf31d8fc874b0000000117cc8b1578ba383544d163958822d8abd3849bb9dfabe39fcbc3e7ee8811fe2f000000070429d069188ebdc0000000000000000000000001000000013cb7d3842e8cee6a0ebd09f1fe884f6861e1b29c0000000117cc8b1578ba383544d163958822d8abd3849bb9dfabe39fcbc3e7ee8811fe2f0000000117cc8b1578ba383544d163958822d8abd3849bb9dfabe39fcbc3e7ee8811fe2f000000050429d069189e000000000001000000000000002b41564d207574696c697479206d6574686f64206275696c6442617365547820746f2073656e6420415641580000000100000009000000015c813cd6f22a8729dd1d12c180009ce5faecc9e5b36cc3ad2ef2c6fbc3ebf771777dc7b0ca4fe24e77c78f3203307147fa3ad41f3304995ad1d2708eda7d835300ce5ba017",
    "timestamp": "2023-01-31T20:03:54.95888-08:00",
    "encoding": "hex",
    "index": "0"
  },
  "id": 1
}
```

Get statistics about a node’s health and performance.

```zsh
avalanche.metrics

avalanche_resource_tracker_disk_available_space 1.8945982464e+11
# HELP avalanche_resource_tracker_disk_reads Disk reads (bytes/sec) tracked by the resource manager
# TYPE avalanche_resource_tracker_disk_reads gauge
avalanche_resource_tracker_disk_reads 0
# HELP avalanche_resource_tracker_disk_writes Disk writes (bytes/sec) tracked by the resource manager
# TYPE avalanche_resource_tracker_disk_writes gauge
avalanche_resource_tracker_disk_writes 0
# HELP avalanche_resource_tracker_processing_time Tracked processing time over all nodes. Value expected to be in [0, number of CPU cores], but can go higher due to IO bound processes and thread multiplexing
# TYPE avalanche_resource_tracker_processing_time gauge
avalanche_resource_tracker_processing_time 0.0004232331598367719
```

List all blockchains deployed on the Avalanche network

```zsh
{
  "jsonrpc": "2.0",
  "result": {
    "blockchains": [
      {
        "id": "22X2bbFdnpEQKi4XvH65N4mJJiiBrP67GnqUEU4gefFAEMUkf5",
        "name": "DemoSubnet0",
        "subnetID": "2TGBXcnwx5PqiXWiqxAKUaNSqDguXNh1mxnp82jui68hxJSZAx",
        "vmID": "X86Aw6Q61dE4TsvsEiHBrYMHaEHwVdScHmJouhZuXcHgWAMTP"
      },
      {
        "id": "VctwH3nkmztWbkdNXbuo6eCYndsUuemtM9ZFmEUZ5QpA1Fu8G",
        "name": "C-Chain",
        "subnetID": "11111111111111111111111111111111LpoYY",
        "vmID": "mgj786NP7uDwBCcq6YwThhaN8FLyybkCa4zBWTQbNgmK6k9A6"
      },
      {
        "id": "qzfF3A11KzpcHkkqznEyQgupQrCNS6WV6fTUTwZpEKqhj1QE7",
        "name": "X-Chain",
        "subnetID": "11111111111111111111111111111111LpoYY",
        "vmID": "jvYyfQTxGMJLuGWa55kdP2p2zSUYsQ5Raupu4TW34ZAUBAbtq"
      }
    ]
  },
  "id": 1
}
```

Get the status of an Atomic transactions

```zsh
avax.getAtomicTxStatus 2QouvFWUbjuySRxeX5xMbNCuAaKWfbk5FeEa2JmoF85RKLk2dD

{
  "jsonrpc": "2.0",
  "result": {
    "status": "Committed"
  },
  "id": 1
}
```

Get transactions status

```zsh
avm.getTxStatus 2qhaVcsUakMQEw7rRLFP94QNMX6vGNggpzBFHeBKARuHhXpcJ8

{
  "jsonrpc": "2.0",
  "result": {
    "status": "Accepted"
  },
  "id": 1
}
```

## Aliases

## Functions

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

### P-Chain

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

### C-Chain

| Command                | Description                                                                                              |
| :--------------------- | :------------------------------------------------------------------------------------------------------- |
| `avax.getAtomicTx <txID> <encoding>`| Gets a transaction by its ID.  |
| `avax.getUTXOs <addresses> <sourceChain> <address> <utxo> <encoding>`| Gets the UTXOs that reference a given address. |
| `avax.issueTx <tx> <encoding>`| Send a signed transaction to the network. |
| `avax.getAtomicTxStatus <txID>`| Get the status of an atomic transaction sent to the network. |
| `avax.getAtomicTxStatus <txID>`| Get the status of an atomic transaction sent to the network. |

### X-Chain

| Command                | Description                                                                                              |
| :--------------------- | :------------------------------------------------------------------------------------------------------- |
| `avm.buildGenesis <networkID> <genesisData> <encoding>`| Create the byte representation of the genesis state. |
| `avm.getAllBalances <address>`| Get the balances of all assets controlled by a given address. |
| `avm.getAssetDescription <assetID>`| Get information about an asset. |
| `avm.getBalance <address> <assetID>`| Get the balance of an asset controlled by a given address. |
| `avm.getAddressTxs <address> <assetID> <pageSize>`| Returns all transactions that change the balance of the given address. |
| `avm.getTx <txID> <encoding>`| Returns the specified transaction. |
| `avm.getTxStatus <txID>`| Get the status of a transaction sent to the network. |
| `avm.getUTXOs <addresses> <limit> <encoding>`| Gets the UTXOs that reference a given address. |
| `avm.issueTx <tx> <encoding>`| Send a signed transaction to the network. |

### Custom

| Command                | Description                                                                                              |
| :--------------------- | :------------------------------------------------------------------------------------------------------- |
| `setAvalancheEnvironment <local> <fuji> <mainnet>`  | Sets the public API url per the environment |

## TODO

- Correctly pass in array parameters
  - nodeIDs
  - addresses
  - ids
- Add other Index endpoints
  - /ext/index/X/vtx
  - /ext/index/P/block
  - /ext/index/C/block
- Document missing argument definitions
