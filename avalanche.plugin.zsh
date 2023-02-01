# Variables

# Default to fuji
AVALANCHE_PUBLIC_API=https://api.avax-test.network/
AVALANCHE_NETWORK=fuji

# Functions

# Sets the public API url per the environment
# Usage: setAvalancheEnvironment <local|fuji|mainnet>
function setAvalancheEnvironment {
  if [[ "$1" == "local" ]]; then
    AVALANCHE_PUBLIC_API=http://127.0.0.1:9650/
    AVALANCHE_NETWORK=local
  elif [[ "$1" == "fuji" ]]; then
    AVALANCHE_PUBLIC_API=https://api.avax-test.network/
    AVALANCHE_NETWORK=fuji
  elif [[ "$1" == "mainnet" ]]; then
    AVALANCHE_PUBLIC_API=https://api.avax.network/
    AVALANCHE_NETWORK=mainnet
  else
    echo must be local, fuji, or mainnet
  fi
}

# Admin
# This API can be used for measuring node health and debugging.
# More info <https://docs.avax.network/apis/avalanchego/apis/admin>

# Assign an API endpoint an alias, a different endpoint for the API. 
# The original endpoint will still work. This change only affects this node; 
# other nodes will not know about this alias.
# Usage: admin.alias <newAlias> <endpoint>
# The API being aliased can now be called at ext/setAlias.
# <newAlias> can be at most 512 characters.
# <endpoint> is the original endpoint of the API. endpoint should only include the part of the endpoint after /ext/.
function admin.alias {
  local newAlias="$1"
  local endpoint="$2"
  curl -X POST --data '{
    "jsonrpc":"2.0",
    "id"     :1,
    "method" :"admin.alias",
    "params": {
      "alias":"'$newAlias'",
      "endpoint":"'$endpoint'"
    }
  }' -H 'content-type:application/json;' "${AVALANCHE_PUBLIC_API}ext/admin"
}

# Give a blockchain an alias, a different name that can be used any place the blockchain’s ID is used.
# Usage: admin.aliasChain <chain> <newAlias>
# <chain> is the blockchain’s ID.
# <newAlias> can now be used in place of the blockchain’s ID (in API endpoints, for example.)
function admin.aliasChain {
  local chain="$1"
  local newAlias="$2"
  curl -X POST --data '{
    "jsonrpc":"2.0",
    "id"     :1,
    "method" :"admin.aliasChain",
    "params": {
      "chain":"'$chain'",
      "alias":"'$newAlias'"
    }
  }' -H 'content-type:application/json;' "${AVALANCHE_PUBLIC_API}ext/admin"
}

# Returns the aliases of the chain
# Usage: admin.getChainAliases <chain>
# <chain> is the blockchain’s ID.
function admin.getChainAliases {
  local chain="$1"
  curl -X POST --data '{
    "jsonrpc":"2.0",
    "id"     :1,
    "method" :"admin.getChainAliases",
    "params": {
      "chain":"'$chain'"
    }
  }' -H 'content-type:application/json;' "${AVALANCHE_PUBLIC_API}ext/admin"
}

# Returns log and display levels of loggers.
# Usage: admin.getLoggerLevel <loggerName>
# <loggerName> is the name of the logger to be returned. This is an optional argument. 
# If not specified, it returns all possible loggers.
function admin.getLoggerLevel {
  local loggerName="$1"
  curl -X POST --data '{
    "jsonrpc":"2.0",
    "id"     :1,
    "method" :"admin.getLoggerLevel",
    "params": {
      "loggerName":"'$loggerName'"
    }
  }' -H 'content-type:application/json;' "${AVALANCHE_PUBLIC_API}ext/admin"
}

# Dynamically loads any virtual machines installed on the node as plugins. 
# Usage: admin.loadVMs
function admin.loadVMs {
  curl -X POST --data '{
    "jsonrpc":"2.0",
    "id"     :1,
    "method" :"admin.loadVMs"
  }' -H 'content-type:application/json;' "${AVALANCHE_PUBLIC_API}ext/admin"
}

# Writes a profile of mutex statistics to lock.profile.
# Usage: admin.lockProfile
function admin.lockProfile {
  curl -X POST --data '{
    "jsonrpc":"2.0",
    "id"     :1,
    "method" :"admin.lockProfile"
  }' -H 'content-type:application/json;' "${AVALANCHE_PUBLIC_API}ext/admin"
}

# Writes a memory profile of the to mem.profile.
# Usage: admin.memoryProfile
function admin.memoryProfile {
  curl -X POST --data '{
    "jsonrpc":"2.0",
    "id"     :1,
    "method" :"admin.memoryProfile"
  }' -H 'content-type:application/json;' "${AVALANCHE_PUBLIC_API}ext/admin"
}

# Sets log and display levels of loggers.
# Usage: admin.setLoggerLevel <loggerName> <logLevel> <displayLevel>
# <loggerName> is the logger's name to be changed. This is an optional parameter. If not specified, it changes all possible loggers.
# <logLevel> is the log level of written logs, can be omitted.
# <displayLevel> is the log level of displayed logs, can be omitted.
function admin.setLoggerLevel {
  local loggerName="$1"
  local logLevel="$2"
  local displayLevel="$3"
  curl -X POST --data '{
    "jsonrpc":"2.0",
    "id"     :1,
    "method" :"admin.setLoggerLevel",
    "params": {
      "loggerName":"'$loggerName'",
      "logLevel": "'$logLevel'",
      "displayLevel": "'$displayLevel'"
    }
  }' -H 'content-type:application/json;' "${AVALANCHE_PUBLIC_API}ext/admin"
}

# Start profiling the CPU utilization of the node. To stop, call admin.stopCPUProfiler. On stop, writes the profile to cpu.profile.
# Usage: admin.startCPUProfiler
function admin.startCPUProfiler {
  curl -X POST --data '{
    "jsonrpc":"2.0",
    "id"     :1,
    "method" :"admin.startCPUProfiler"
  }' -H 'content-type:application/json;' "${AVALANCHE_PUBLIC_API}ext/admin"
}

# Stop the CPU profile that was previously started.
# Usage: admin.stopCPUProfiler
function admin.stopCPUProfiler {
  curl -X POST --data '{
    "jsonrpc":"2.0",
    "id"     :1,
    "method" :"admin.stopCPUProfiler"
  }' -H 'content-type:application/json;' "${AVALANCHE_PUBLIC_API}ext/admin"
}

# Auth
# When you run a node, you can require that API calls have an authorization token attached. 
# This API manages the creation and revocation of authorization tokens.
# More info <https://docs.avax.network/apis/avalanchego/apis/auth>

# Creates a new authorization token that grants access to one or more API endpoints.
# Usage: auth.newToken <password> <endpoints>
# <password> is this node’s authorization token password.
# <endpoints> is a list of endpoints that will be accessible using the generated token. 
# If endpoints contains an element "*", the generated token can access any API endpoint.
# TODO - correctly pass in array of endpoints
function auth.newToken {
  local password="$1"
  local endpoints=["$2"]
  curl -X POST --data '{
    "jsonrpc":"2.0",
    "id"     :1,
    "method" :"auth.newToken",
    "params": {
      "password":"'$password'",
      "endpoints":'$endpoints'
    }
  }' -H 'content-type:application/json;' "${AVALANCHE_PUBLIC_API}ext/auth"
}

# Revoke a previously generated token. The given token will no longer grant access to any endpoint. If the token is invalid, does nothing.
# Usage: auth.revokeToken <password> <token> 
# <password> is this node’s authorization token password.
# <token> is the authorization token being revoked.
function auth.revokeToken {
  local password="$1"
  local token="$2"
  curl -X POST --data '{
    "jsonrpc":"2.0",
    "id"     :1,
    "method" :"auth.revokeToken",
    "params": {
      "password":"'$password'",
      "token":"'$token'"
    }
  }' -H 'content-type:application/json;' "${AVALANCHE_PUBLIC_API}ext/auth"
}

# Change this node’s authorization token password. Any authorization tokens created under an old password will become invalid.
# Usage: auth.changePassword <oldPassword> <newPassword>
# <oldPassword> is this node’s current authorization token password.
# <newPassword> is the node’s new authorization token password after this API call. Must be between 1 and 1024 characters.
function auth.changePassword {
  local oldPassword="$1"
  local newPassword="$2"
  curl -X POST --data '{
    "jsonrpc":"2.0",
    "id"     :1,
    "method" :"auth.changePassword",
    "params": {
      "oldPassword":"'$oldPassword'",
      "newPassword":"'$newPassword'"
    }
  }' -H 'content-type:application/json;' "${AVALANCHE_PUBLIC_API}ext/auth"
}

# Health
# This API can be used for measuring node health.
# More info <https://docs.avax.network/apis/avalanchego/apis/health>

# The node runs a set of health checks every 30 seconds, including a health check for each chain. 
# This method returns the last set of health check results.
# Usage: avalanche.health
function avalanche.health {
  curl -X POST --data '{
    "jsonrpc":"2.0",
    "id"     :1,
    "method" :"health.health"
  }' -H 'content-type:application/json;' "${AVALANCHE_PUBLIC_API}ext/health"
}

# Index
# AvalancheGo can be configured to run with an indexer. 
# That is, it saves (indexes) every container (a block, vertex or transaction) it accepts on the X-Chain, P-Chain and C-Chain. 
# To run AvalancheGo with indexing enabled, set command line flag <--index-enabled> to true. 
# AvalancheGo will only index containers that are accepted when running with <--index-enabled> set to true
# More info <https://docs.avax.network/apis/avalanchego/apis/index-api>
# TODO - add other endpoints
# - /ext/index/X/vtx
# - /ext/index/P/block
# - /ext/index/C/block

# Get the most recently accepted container.
# Usage: index.getLastAccepted <encoding>
# <encoding> is "hex" only.
function index.getLastAccepted {
  local encoding="$1"
  curl -X POST --data '{
    "jsonrpc":"2.0",
    "id"     :1,
    "method" :"index.getLastAccepted",
    "params": {
      "encoding":"'$encoding'"
    }
  }' -H 'content-type:application/json;' "${AVALANCHE_PUBLIC_API}ext/index/X/tx"
}

# Get container by index. The first container accepted is at index 0, the second is at index 1, etc.
# Usage: index.getContainerByIndex <index> <encoding>
# <index> is how many containers were accepted in this index before this one
# <encoding> is "hex" only.
function index.getContainerByIndex {
  local index="$1"
  local encoding="$2"
  curl -X POST --data '{
    "jsonrpc":"2.0",
    "id"     :1,
    "method" :"index.getContainerByIndex",
    "params": {
      "index": "'$index'",
      "encoding":"'$encoding'"
    }
  }' -H 'content-type:application/json;' "${AVALANCHE_PUBLIC_API}ext/index/X/tx"
}

# Get container by ID.
# Usage: index.getContainerByID <id> <encoding>
# <id> is the container's ID
# <encoding> is "hex" only.
function index.getContainerByID {
  local id="$1"
  local encoding="$2"
  curl -X POST --data '{
    "jsonrpc":"2.0",
    "id"     :1,
    "method" :"index.getContainerByID",
    "params": {
      "id": "'$id'",
      "encoding":"'$encoding'"
    }
  }' -H 'content-type:application/json;' "${AVALANCHE_PUBLIC_API}ext/index/X/tx"
}

# Returns containers with indices in [startIndex, startIndex+1, ... , startIndex + numToFetch
# Usage: index.getContainerRange <startIndex> <numToFetch> <encoding>
# <startIndex> is the beginning index
# <numToFetch> is the number of containers to fetch
# <encoding> is "hex" only.
function index.getContainerRange {
  local startIndex="$1"
  local numToFetch="$2"
  local encoding="$3"
  curl -X POST --data '{
    "jsonrpc":"2.0",
    "id"     :1,
    "method" :"index.getContainerRange",
    "params": {
      "startIndex": "'$startIndex'",
      "numToFetch": "'$numToFetch'",
      "encoding":"'$encoding'"
    }
  }' -H 'content-type:application/json;' "${AVALANCHE_PUBLIC_API}ext/index/X/tx"
}

# Get a container's index.
# Usage: index.getIndex <id> <encoding>
# <id> is the ID of the container to fetch
# <encoding> is "hex" only.
function index.getIndex {
  local id="$1"
  local encoding="$2"
  curl -X POST --data '{
    "jsonrpc":"2.0",
    "id"     :1,
    "method" :"index.getIndex",
    "params": {
      "id": "'$id'",
      "encoding":"'$encoding'"
    }
  }' -H 'content-type:application/json;' "${AVALANCHE_PUBLIC_API}ext/index/X/tx"
}

# Returns true if the container is in this index.
# Usage: index.isAccepted <id> <encoding>
# <id> is the ID of the container to fetch
# <encoding> is "hex" only.
function index.isAccepted {
  local id="$1"
  local encoding="$2"
  curl -X POST --data '{
    "jsonrpc":"2.0",
    "id"     :1,
    "method" :"index.isAccepted",
    "params": {
      "id": "'$id'",
      "encoding":"'$encoding'"
    }
  }' -H 'content-type:application/json;' "${AVALANCHE_PUBLIC_API}ext/index/X/tx"
}

# Info
# This API can be used to access basic information about the node.
# More info <https://docs.avax.network/apis/avalanchego/apis/info>

# Given a blockchain’s alias, get its ID. 
# Usage: info.getBlockchainID <alias>
# <alias> is the blockchain’s alias.
function info.getBlockchainID {
  local alias="$1"
  curl -X POST --data '{
    "jsonrpc":"2.0",
    "id"     :1,
    "method" :"info.getBlockchainID",
    "params": {
      "alias":"'$alias'"
    }
  }' -H 'content-type:application/json;' "${AVALANCHE_PUBLIC_API}ext/info"
}

# Get the ID of the network this node is participating in.
# Usage: info.getNetworkID
function info.getNetworkID {
  curl -X POST --data '{
    "jsonrpc":"2.0",
    "id"     :1,
    "method" :"info.getNetworkID"
  }' -H 'content-type:application/json;' "${AVALANCHE_PUBLIC_API}ext/info"
}

# Get the name of the network this node is participating in.
# Usage: info.getNetworkName
function info.getNetworkName {
  curl -X POST --data '{
    "jsonrpc":"2.0",
    "id"     :1,
    "method" :"info.getNetworkName"
  }' -H 'content-type:application/json;' "${AVALANCHE_PUBLIC_API}ext/info"
}

# Get the ID of this node.
# Usage: info.getNodeID
function info.getNodeID {
  curl -X POST --data '{
    "jsonrpc":"2.0",
    "id"     :1,
    "method" :"info.getNodeID"
  }' -H 'content-type:application/json;' "${AVALANCHE_PUBLIC_API}ext/info"
}

# Get the IP of this node.
# Usage: info.getNodeIP
function info.getNodeIP {
  curl -X POST --data '{
    "jsonrpc":"2.0",
    "id"     :1,
    "method" :"info.getNodeIP"
  }' -H 'content-type:application/json;' "${AVALANCHE_PUBLIC_API}ext/info"
}

# Get the version of this node.
# Usage: info.getNodeVersion
function info.getNodeVersion {
  curl -X POST --data '{
    "jsonrpc":"2.0",
    "id"     :1,
    "method" :"info.getNodeVersion"
  }' -H 'content-type:application/json;' "${AVALANCHE_PUBLIC_API}ext/info"
}

# Get the virtual machines installed on this node.
# Usage: info.getVMs
function info.getVMs {
  curl -X POST --data '{
    "jsonrpc":"2.0",
    "id"     :1,
    "method" :"info.getVMs"
  }' -H 'content-type:application/json;' "${AVALANCHE_PUBLIC_API}ext/info"
}

# Check whether a given chain is done bootstrapping
# Usage: info.isBootstrapped <chain>
# <chain> is the ID or alias of a chain.
function info.isBootstrapped {
  local chain="$1"
  curl -X POST --data '{
    "jsonrpc":"2.0",
    "id"     :1,
    "method" :"info.isBootstrapped",
    "params": {
      "chain":"'$chain'"
    }
  }' -H 'content-type:application/json;' "${AVALANCHE_PUBLIC_API}ext/info"
}

# Get a description of peer connections.
# Usage: info.peers <nodeIDs>
# TODO - correctly pass in array of nodeIDs
# <nodeIDs> is an optional parameter to specify what NodeID's descriptions should be returned. 
# If this parameter is left empty, descriptions for all active connections will be returned. 
# If the node is not connected to a specified nodeID, it will be omitted from the response.
function info.peers {
  local nodeIDs=["$1"]
  # echo $nodeIDs
  curl -X POST --data '{
    "jsonrpc":"2.0",
    "id"     :1,
    "method" :"info.peers",
    "params": {
      "nodeIDs":'$nodeIDs'
    }
  }' -H 'content-type:application/json;' "${AVALANCHE_PUBLIC_API}ext/info"
}

# Get the fees of the network.
# Usage: info.getTxFee
function info.getTxFee {
  curl -X POST --data '{
    "jsonrpc":"2.0",
    "id"     :1,
    "method" :"info.getTxFee"
  }' -H 'content-type:application/json;' "${AVALANCHE_PUBLIC_API}ext/info"
}

# Returns the network's observed uptime of this node.
# Usage: info.uptime
function info.uptime {
  curl -X POST --data '{
    "jsonrpc":"2.0",
    "id"     :1,
    "method" :"info.uptime"
  }' -H 'content-type:application/json;' "${AVALANCHE_PUBLIC_API}ext/info"
}

# IPC
# The IPC API allows users to create Unix domain sockets for blockchains to publish to. 
# When the blockchain accepts a vertex/block it will publish it to a socket and the decisions contained inside will be published to another.
# A node will only expose this API if it is started with config flag <api-ipcs-enabled=true>.
# More info <https://docs.avax.network/apis/avalanchego/apis/ipc>

# Register a blockchain so it publishes accepted vertices to a Unix domain socket.
# Usage: ipcs.publishBlockchain <blockchainID>
# <blockchainID> is the blockchain that will publish accepted vertices.
function ipcs.publishBlockchain {
  local blockchainID="$1"
  curl -X POST --data '{
    "jsonrpc":"2.0",
    "id"     :1,
    "method" :"ipcs.publishBlockchain",
    "params": {
      "blockchainID":"'$blockchainID'"
    }
  }' -H 'content-type:application/json;' "${AVALANCHE_PUBLIC_API}ext/ipcs"
}

# Deregister a blockchain so that it no longer publishes to a Unix domain socket.
# Usage: ipcs.unpublishBlockchain <blockchainID>
# <blockchainID> is the blockchain that will no longer publish to a Unix domain socket.
function ipcs.unpublishBlockchain {
  local blockchainID="$1"
  curl -X POST --data '{
    "jsonrpc":"2.0",
    "id"     :1,
    "method" :"ipcs.unpublishBlockchain",
    "params": {
      "blockchainID":"'$blockchainID'"
    }
  }' -H 'content-type:application/json;' "${AVALANCHE_PUBLIC_API}ext/ipcs"
}

# Metrics
# The API allows clients to get statistics about a node’s health and performance.
# More info <https://docs.avax.network/apis/avalanchego/apis/metrics>

# To get the node metrics.
# Usage: avalanche.metrics
function avalanche.metrics {
  curl --location --request POST "${AVALANCHE_PUBLIC_API}ext/metrics" --data-raw ''
}

# P-Chain
# This API allows clients to interact with the P-Chain, 
# Which maintains Avalanche’s validator set and handles blockchain creation.
# More info <https://docs.avax.network/apis/avalanchego/apis/p-chain>

# Get the balance of AVAX controlled by a given address.
# Usage: platform.getBalance [<addresses>]
# <address> is the address to get the balance of.
# TODO - correctly pass in array of addresses
function platform.getBalance {
  local addresses=["$1"]
  echo $addresses
  curl -X POST --data '{
    "jsonrpc":"2.0",
    "id"     :1,
    "method" :"platform.getBalance",
    "params": {
      "addresses":'$addresses'
    }
  }' -H 'content-type:application/json;' "${AVALANCHE_PUBLIC_API}ext/bc/P"
}

# Get a block by its ID.
# Usage: platform.getBlock <blockID> <encoding>
# <blockID> is the block ID. It should be in cb58 format.
# <encoding> is the encoding format to use. Can be either hex or json. Defaults to hex.
function platform.getBlock {
  local blockID="$1"
  local encoding="$2"
  curl -X POST --data '{
    "jsonrpc":"2.0",
    "id"     :1,
    "method" :"platform.getBlock",
    "params": {
        "blockID":"'$blockID'",
        "encoding":"'$encoding'"
    }
  }' -H 'content-type:application/json;' "${AVALANCHE_PUBLIC_API}ext/bc/P"
}

# Get all the blockchains that exist (excluding the P-Chain).
# Usage: platform.getBlockchains
function platform.getBlockchains {
  curl -X POST --data '{
    "jsonrpc":"2.0",
    "id"     :1,
    "method" :"platform.getBlockchains"
  }' -H 'content-type:application/json;' "${AVALANCHE_PUBLIC_API}ext/bc/P"
}

# Get the status of a blockchain.
# <blockchainID> is the blockchain's ID.
# Usage: platform.getBlockchainStatus <blockchainID>
function platform.getBlockchainStatus {
  local blockchainID="$1"
  curl -X POST --data '{
    "jsonrpc":"2.0",
    "id"     :1,
    "method" :"platform.getBlockchainStatus",
    "params": {
        "blockchainID":"'$blockchainID'"
    }
  }' -H 'content-type:application/json;' "${AVALANCHE_PUBLIC_API}ext/bc/P"
}

# Returns an upper bound on amount of tokens that exist that can stake the requested Subnet. 
# This is an upper bound because it does not account for burnt tokens, including transaction fees.
# Usage: platform.getCurrentSupply <subnetID>
function platform.getCurrentSupply {
  local subnetID="$1"
  curl -X POST --data '{
    "jsonrpc":"2.0",
    "id"     :1,
    "method" :"platform.getCurrentSupply",
    "params": {
        "subnetID":"'$subnetID'"
    }
  }' -H 'content-type:application/json;' "${AVALANCHE_PUBLIC_API}ext/bc/P"
}

# List the current validators of the given Subnet.
# Usage: platform.getCurrentValidators <subnetID> [<nodeIDs>]
# <subnetID> is the Subnet whose current validators are returned. 
# If omitted, returns the current validators of the Primary Network.
# <nodeIDs> is a list of the NodeIDs of current validators to request. 
# If omitted, all current validators are returned. 
# If a specified nodeID is not in the set of current validators, it will not be included in the response.
# TODO - correctly pass in array of nodeIDs
function platform.getCurrentValidators {
  local subnetID="$1"
  local nodeIDs=["$2"]
  curl -X POST --data '{
    "jsonrpc":"2.0",
    "id"     :1,
    "method" :"platform.getCurrentValidators",
    "params": {
      "subnetID":"'$subnetID'",
      "nodeIDs":'$nodeIDs'
    }
  }' -H 'content-type:application/json;' "${AVALANCHE_PUBLIC_API}ext/bc/P"
}

# Returns the height of the last accepted block.
# Usage: platform.getHeight
function platform.getHeight {
  curl -X POST --data '{
    "jsonrpc":"2.0",
    "id"     :1,
    "method" :"platform.getHeight"
  }' -H 'content-type:application/json;' "${AVALANCHE_PUBLIC_API}ext/bc/P"
}

# Returns the maximum amount of nAVAX staking to the named node during a particular time period.
# Usage: platform.getMaxStakeAmount <subnetID> <nodeID> <startTime> <endTime>
# <subnetID> is a cb58 string representing Subnet
# <nodeID> is a string representing ID of the node whose stake amount is required during the given duration
# <startTime> is a big number denoting start time of the duration during which stake amount of the node is required.
# <endTime> is a big number denoting end time of the duration during which stake amount of the node is required.
function platform.getMaxStakeAmount {
  local subnetID="$1"
  local nodeID="$2"
  local startTime="$3"
  local endTime="$4"
  curl -X POST --data '{
    "jsonrpc":"2.0",
    "id"     :1,
    "method" :"platform.getMaxStakeAmount",
    "params": {
      "subnetID":"'$subnetID'",
      "nodeID":"'$nodeID'",
      "startTime":"'$startTime'",
      "endTime":"'$endTime'"
    }
  }' -H 'content-type:application/json;' "${AVALANCHE_PUBLIC_API}ext/bc/P"
}

# Get the minimum amount of tokens required to validate the requested Subnet and the minimum amount of tokens that can be delegated.
# Usage: platform.getMinStake <subnetID>
# <subnetID> is a cb58 string representing Subnet
function platform.getMinStake {
  local subnetID="$1"
  curl -X POST --data '{
    "jsonrpc":"2.0",
    "id"     :1,
    "method" :"platform.getMinStake",
    "params": {
      "subnetID":"'$subnetID'"
    }
  }' -H 'content-type:application/json;' "${AVALANCHE_PUBLIC_API}ext/bc/P"
}

# List the validators in the pending validator set of the specified Subnet. Each validator is not currently validating the Subnet but will in the future.
# Usage: platform.getPendingValidators <subnetID> [<nodeIDs>]
# <subnetID> is the Subnet whose current validators are returned. 
# If omitted, returns the current validators of the Primary Network.
# <nodeIDs> is a list of the NodeIDs of pending validators to request. 
# If omitted, all pending validators are returned. If a specified nodeID is not in the set of pending validators, it will not be included in the response.
# TODO - correctly pass in array of nodeIDs
function platform.getPendingValidators {
  local subnetID="$1"
  local nodeIDs=["$2"]
  curl -X POST --data '{
    "jsonrpc":"2.0",
    "id"     :1,
    "method" :"platform.getPendingValidators",
    "params": {
      "subnetID":"'$subnetID'",
      "nodeIDs":'$nodeIDs'
    }
  }' -H 'content-type:application/json;' "${AVALANCHE_PUBLIC_API}ext/bc/P"
}

# Returns the UTXOs that were rewarded after the provided transaction's staking or delegation period ended.
# Usage: platform.getRewardUTXOs <txID> <encoding>
# <txID> is the ID of the staking or delegating transaction
# <encoding> is "hex" only.
# TODO - properly format arguments
function platform.getRewardUTXOs {
  local txID="$1"
  local encoding="$2"
  curl -X POST --data '{
    "jsonrpc":"2.0",
    "id"     :1,
    "method" :"platform.getRewardUTXOs",
    "params": {
      "txID":"'$txID'",
      "encoding":"'$encoding'"
    }
  }' -H 'content-type:application/json;' "${AVALANCHE_PUBLIC_API}ext/bc/P"
}

# Retrieve an assetID for a Subnet’s staking asset.
# Usage: platform.getStakingAssetID <subnetID>
# <subnetID> is the Subnet whose assetID is requested.
function platform.getStakingAssetID {
  local subnetID="$1"
  curl -X POST --data '{
    "jsonrpc":"2.0",
    "id"     :1,
    "method" :"platform.getStakingAssetID",
    "params": {
      "subnetID":"'$subnetID'"
    }
  }' -H 'content-type:application/json;' "${AVALANCHE_PUBLIC_API}ext/bc/P"
}

# Get info about the Subnets.
# Usage: platform.getSubnets [<ids>]
# <ids> are the IDs of the Subnets to get information about. If omitted, gets information about all Subnets.
# TODO - correctly pass in array of ids
function platform.getSubnets {
  local ids=["$1"]
  curl -X POST --data '{
    "jsonrpc":"2.0",
    "id"     :1,
    "method" :"platform.getSubnets",
    "params": {
      "ids":'$ids'
    }
  }' -H 'content-type:application/json;' "${AVALANCHE_PUBLIC_API}ext/bc/P"
}

# Get the amount of nAVAX staked by a set of addresses. The amount returned does not include staking rewards.
# Usage: platform.getStake <ids>
# <addresses> are the addresses to get information about.
# TODO - correctly pass in array of addresses
function platform.getStake {
  local addresses=["$1"]
  curl -X POST --data '{
    "jsonrpc":"2.0",
    "id"     :1,
    "method" :"platform.getStake",
    "params": {
      "addresses":'$addresses'
    }
  }' -H 'content-type:application/json;' "${AVALANCHE_PUBLIC_API}ext/bc/P"
}

# Get the current P-Chain timestamp.
# Usage: platform.getTimestamp
function platform.getTimestamp {
  curl -X POST --data '{
    "jsonrpc":"2.0",
    "id"     :1,
    "method" :"platform.getTimestamp"
  }' -H 'content-type:application/json;' "${AVALANCHE_PUBLIC_API}ext/bc/P"
}

# Get the total amount of tokens staked on the requested Subnet.
# Usage: platform.getTotalStake <subnetID>
# <subnetID> is a cb58 string representing Subnet
function platform.getTotalStake {
  local subnetID="$1"
  curl -X POST --data '{
    "jsonrpc":"2.0",
    "id"     :1,
    "method" :"platform.getTotalStake",
    "params": {
      "subnetID":"'$subnetID'"
    }
  }' -H 'content-type:application/json;' "${AVALANCHE_PUBLIC_API}ext/bc/P"
}

# Gets a transaction by its ID.
# Usage: platform.getTx <txID> <encoding>
# <txID> is the ID of the transaction
# <encoding> parameter to specify the format for the returned transaction. Can be either hex or json. Defaults to hex.
function platform.getTx {
  local txID="$1"
  local encoding="$2"
  curl -X POST --data '{
    "jsonrpc":"2.0",
    "id"     :1,
    "method" :"platform.getTx",
    "params": {
      "txID":"'$txID'",
      "encoding":"'$encoding'"
    }
  }' -H 'content-type:application/json;' "${AVALANCHE_PUBLIC_API}ext/bc/P"
}

# Gets a transaction’s status by its ID. 
# If the transaction was dropped, response will include a reason field with more information why the transaction was dropped.
# Usage: platform.getTxStatus <txID>
# <txID> is the ID of the transaction
function platform.getTxStatus {
  local txID="$1"
  curl -X POST --data '{
    "jsonrpc":"2.0",
    "id"     :1,
    "method" :"platform.getTxStatus",
    "params": {
      "txID":"'$txID'"
    }
  }' -H 'content-type:application/json;' "${AVALANCHE_PUBLIC_API}ext/bc/P"
}

# Gets the UTXOs that reference a given set of addresses.
# Usage: platform.getUTXOs <addresses> <limit> <encoding>
# <addresses> are the addresses to get the UTXOs for.
# <limit> UTXOs are returned. If limit is omitted or greater than 1024, it is set to 1024.
# <encoding> specifies the format for the returned UTXOs. Can only be hex when a value is provided.
# TODO - correctly pass in array of addresses
function platform.getUTXOs {
  local addresses=["$1"]
  local limit="$2"
  local encoding="$3"
  curl -X POST --data '{
    "jsonrpc":"2.0",
    "id"     :1,
    "method" :"platform.getUTXOs",
    "params": {
      "addresses":'$addresses',
      "limit":"'$limit'",
      "encoding":"'$encoding'"
    }
  }' -H 'content-type:application/json;' "${AVALANCHE_PUBLIC_API}ext/bc/P"
}

# Get the validators and their weights of a Subnet or the Primary Network at a given P-Chain height.
# Usage: platform.getValidatorsAt <height> <subnetID>
# <height> is the P-Chain height to get the validator set at.
# <subnetID> is the Subnet ID to get the validator set of. If not given, gets validator set of the Primary Network.
function platform.getValidatorsAt {
  local height="$1"
  local subnetID="$2"
  curl -X POST --data '{
    "jsonrpc":"2.0",
    "id"     :1,
    "method" :"platform.getValidatorsAt",
    "params": {
      "height":"'$height'",
      "subnetID":"'$subnetID'"
    }
  }' -H 'content-type:application/json;' "${AVALANCHE_PUBLIC_API}ext/bc/P"
}

# Issue a transaction to the Platform Chain.
# Usage: platform.issueTx <tx> <encoding>
# <tx> is the byte representation of a transaction.
# <encoding> specifies the encoding format for the transaction bytes. Can only be hex when a value is provided.
function platform.issueTx {
  local tx="$1"
  local encoding="$2"
  curl -X POST --data '{
    "jsonrpc":"2.0",
    "id"     :1,
    "method" :"platform.issueTx",
    "params": {
      "tx":"'$tx'",
      "encoding":"'$encoding'"
    }
  }' -H 'content-type:application/json;' "${AVALANCHE_PUBLIC_API}ext/bc/P"
}

# Sample validators from the specified Subnet.
# Usage: platform.sampleValidators <tx> <encoding>
# <size> is the number of validators to sample.
# <subnetID> is the Subnet to sampled from. If omitted, defaults to the Primary Network.
# TODO - properly format arguments
function platform.sampleValidators {
  local size="$1"
  local encoding="$2"
  curl -X POST --data '{
    "jsonrpc":"2.0",
    "id"     :1,
    "method" :"platform.sampleValidators",
    "params": {
      "size":"'$size'",
      "subnetID":"'$subnetID'"
    }
  }' -H 'content-type:application/json;' "${AVALANCHE_PUBLIC_API}ext/bc/P"
}

# Get the Subnet that validates a given blockchain.
# Usage: platform.validatedBy <blockchainID>
# <blockchainID> is the blockchain’s ID.
function platform.validatedBy {
  local blockchainID="$1"
  curl -X POST --data '{
    "jsonrpc":"2.0",
    "id"     :1,
    "method" :"platform.validatedBy",
    "params": {
      "blockchainID":"'$blockchainID'"
    }
  }' -H 'content-type:application/json;' "${AVALANCHE_PUBLIC_API}ext/bc/P"
}

# Get the IDs of the blockchains a Subnet validates.
# Usage: platform.validates <subnetID>
# <subnetID> is the Subnet’s ID.
function platform.validates {
  local subnetID="$1"
  curl -X POST --data '{
    "jsonrpc":"2.0",
    "id"     :1,
    "method" :"platform.validates",
    "params": {
      "subnetID":"'$subnetID'"
    }
  }' -H 'content-type:application/json;' "${AVALANCHE_PUBLIC_API}ext/bc/P"
}

# C-Chain
# This API allows clients to interact with the C-Chain, 
# Which is an instance of the EVM.
# More info <https://docs.avax.network/apis/avalanchego/apis/c-chain>

# Gets a transaction by its ID. 
# Usage: avax.getAtomicTx <txID> <encoding>
# <txID> is the transaction ID. It should be in cb58 format.
# <encoding> is the encoding format to use. Can only be hex when a value is provided.
function avax.getAtomicTx {
  local txID="$1"
  local encoding="$2"
  curl -X POST --data '{
    "jsonrpc":"2.0",
    "id"     :1,
    "method" :"avax.getAtomicTx",
    "params": {
      "txID":"'$txID'",
      "encoding":"'$encoding'"
    }
  }' -H 'content-type:application/json;' "${AVALANCHE_PUBLIC_API}ext/bc/C/avax"
}

# Gets the UTXOs that reference a given address.
# Usage: avax.getUTXOs <addresses> <sourceChain> <address> <utxo> <encoding>
# TODO - correctly pass in array of addresses
# TODO - get arg defs
function avax.getUTXOs {
  local addresses=["$1"]
  local sourceChain="$2"
  local address="$3"
  local utxo="$4"
  local encoding="$5"
  curl -X POST --data '{
    "jsonrpc":"2.0",
    "id"     :1,
    "method" :"avax.getUTXOs",
    "params": {
      "addresses":'$addresses',
      "sourceChain":"'$sourceChain'",
      "startIndex":{
        "address":"'$address'",
        "utxo":"'$utxo'"
      },
      "encoding":"'$encoding'"
    }
  }' -H 'content-type:application/json;' "${AVALANCHE_PUBLIC_API}ext/bc/C/avax"
}

# Send a signed transaction to the network.
# Usage: avax.issueTx <tx> <encoding>
# <tx> is the byte representation of a transaction.
# <encoding> specifies the encoding format for the transaction bytes. Can only be hex when a value is provided.
function avax.issueTx {
  local tx="$1"
  local encoding="$2"
  curl -X POST --data '{
    "jsonrpc":"2.0",
    "id"     :1,
    "method" :"avax.issueTx",
    "params": {
      "tx":"'$tx'",
      "encoding":"'$encoding'"
    }
  }' -H 'content-type:application/json;' "${AVALANCHE_PUBLIC_API}ext/bc/C/avax"
}

# Get the status of an atomic transaction sent to the network.
# Usage: avax.getAtomicTxStatus <txID>
# <txID> is the ID of the transaction
function avax.getAtomicTxStatus {
  local txID="$1"
  curl -X POST --data '{
    "jsonrpc":"2.0",
    "id"     :1,
    "method" :"avax.getAtomicTxStatus",
    "params": {
      "txID":"'$txID'"
    }
  }' -H 'content-type:application/json;' "${AVALANCHE_PUBLIC_API}ext/bc/C/avax"
}

# AVM
# The X-Chain, Avalanche’s native platform for creating and trading assets, is an instance of the Avalanche Virtual Machine (AVM). 
# This API allows clients to create and trade assets on the X-Chain and other instances of the AVM.
# More info <https://docs.avax.network/apis/avalanchego/apis/x-chain>

# Given a JSON representation of this Virtual Machine’s genesis state, create the byte representation of that state.
# Usage: avm.buildGenesis <networkID> <genesisData> <encoding>
# TODO - get arg defs
function avm.buildGenesis {
  local networkID="$1"
  local genesisData="$2"
  local encoding="$3"
  curl -X POST --data '{
    "jsonrpc":"2.0",
    "id"     :1,
    "method" :"avm.buildGenesis",
    "params": {
      "networkID":"'$networkID'",
      "genesisData":"'$genesisData'",
      "encoding":"'$encoding'",
    }
  }' -H 'content-type:application/json;' "${AVALANCHE_PUBLIC_API}ext/vm/avm"
}

# Get the balances of all assets controlled by a given address.
# Usage: avm.getAllBalances <address>
# <address> is the address to get the balances of.
function avm.getAllBalances {
  local address="$1"
  curl -X POST --data '{
    "jsonrpc":"2.0",
    "id"     :1,
    "method" :"avm.getAllBalances",
    "params": {
      "address":"'$address'"
    }
  }' -H 'content-type:application/json;' "${AVALANCHE_PUBLIC_API}ext/bc/X"
}

# Get information about an asset.
# Usage: avm.getAssetDescription <assetID>
# <assetID> is the id of the asset for which the information is requested.
function avm.getAssetDescription {
  local assetID="$1"
  curl -X POST --data '{
    "jsonrpc":"2.0",
    "id"     :1,
    "method" :"avm.getAssetDescription",
    "params": {
      "assetID":"'$assetID'"
    }
  }' -H 'content-type:application/json;' "${AVALANCHE_PUBLIC_API}ext/bc/X"
}

# Get the balance of an asset controlled by a given address.
# Usage: avm.getBalance <address> <assetID>
# <address> owner of the asset
# <assetID> id of the asset for which the balance is requested
function avm.getBalance {
  local address="$1"
  local assetID="$2"
  curl -X POST --data '{
    "jsonrpc":"2.0",
    "id"     :1,
    "method" :"avm.getBalance",
    "params": {
      "address":"'$address'",
      "assetID":"'$assetID'"
    }
  }' -H 'content-type:application/json;' "${AVALANCHE_PUBLIC_API}ext/bc/X"
}

# Returns all transactions that change the balance of the given address. A transaction is said to change an address's balance if either is true:
# Usage: avm.getAddressTxs <address> <assetID> <pageSize>
# <address> The address for which we're fetching related transactions
# <assetID> Only return transactions that changed the balance of this asset. Must be an ID or an alias for an asset.
# <pageSize> Number of items to return per page. Optional. Defaults to 1024.
function avm.getAddressTxs {
  local address="$1"
  local assetID="$2"
  local pageSize="$3"
  curl -X POST --data '{
    "jsonrpc":"2.0",
    "id"     :1,
    "method" :"avm.getAddressTxs",
    "params": {
      "address":"'$address'",
      "assetID":"'$assetID'",
      "pageSize":"'$pageSize'"
    }
  }' -H 'content-type:application/json;' "${AVALANCHE_PUBLIC_API}ext/bc/X"
}

# Returns the specified transaction.
# Usage: avm.getTx <txID> <encoding>
# <txID> is the ID of the transaction.
# <encoding> is "hex" only.
function avm.getTx {
  local txID="$1"
  local encoding="$2"
  curl -X POST --data '{
    "jsonrpc":"2.0",
    "id"     :1,
    "method" :"avm.getTx",
    "params": {
      "txID":"'$txID'",
      "encoding":"'$encoding'"
    }
  }' -H 'content-type:application/json;' "${AVALANCHE_PUBLIC_API}ext/bc/X"
}

# Get the status of a transaction sent to the network.
# Usage avm.getTxStatus <txID>
# <txID> is the ID of the transaction.
function avm.getTxStatus {
  local txID="$1"
  curl -X POST --data '{
    "jsonrpc":"2.0",
    "id"     :1,
    "method" :"avm.getTxStatus",
    "params": {
      "txID":"'$txID'"
    }
  }' -H 'content-type:application/json;' "${AVALANCHE_PUBLIC_API}ext/bc/X"
}

# Gets the UTXOs that reference a given address. If sourceChain is specified, then it will retrieve the atomic UTXOs exported from that chain to the X Chain.
# Usage: avm.getUTXOs <addresses> <limit> <encoding>
# <addresses> are the addresses to get the UTXOs for.
# <limit> UTXOs are returned. If limit is omitted or greater than 1024, it is set to 1024.
# <encoding> specifies the format for the returned UTXOs. Can only be hex when a value is provided.
# TODO - correctly pass in array of addresses
function avm.getUTXOs {
  local addresses=["$1"]
  local limit="$2"
  local encoding="$3"
  curl -X POST --data '{
    "jsonrpc":"2.0",
    "id"     :1,
    "method" :"avm.getUTXOs",
    "params": {
      "addresses":'$addresses',
      "limit":"'$limit'",
      "encoding":"'$encoding'"
    }
  }' -H 'content-type:application/json;' "${AVALANCHE_PUBLIC_API}ext/bc/X"
}

# Send a signed transaction to the network.
# Usage: avm.issueTx <tx> <encoding>
# <tx> is the byte representation of a transaction.
# <encoding> specifies the encoding format for the transaction bytes. Can only be hex when a value is provided.
function avm.issueTx {
  local tx="$1"
  local encoding="$2"
  curl -X POST --data '{
    "jsonrpc":"2.0",
    "id"     :1,
    "method" :"avm.issueTx",
    "params": {
      "tx":"'$tx'",
      "encoding":"'$encoding'"
    }
  }' -H 'content-type:application/json;' "${AVALANCHE_PUBLIC_API}ext/bc/X"
}