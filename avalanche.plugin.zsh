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

# Assign an API endpoint an alias, a different endpoint for the API. 
# The original endpoint will still work. This change only affects this node; 
# other nodes will not know about this alias.
# Usage: setAlias <newAlias> <endpoint>
# The API being aliased can now be called at ext/setAlias.
# <newAlias> can be at most 512 characters.
# <endpoint> is the original endpoint of the API. endpoint should only include the part of the endpoint after /ext/.
function setAlias {
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
# Usage: aliasChain <chain> <newAlias>
# <chain> is the blockchain’s ID.
# <newAlias> can now be used in place of the blockchain’s ID (in API endpoints, for example.)
function aliasChain {
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
# Usage: getChainAliases <chain>
# <chain> is the blockchain’s ID.
function getChainAliases {
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
# Usage: getLoggerLevel <loggerName>
# <loggerName> is the name of the logger to be returned. This is an optional argument. 
# If not specified, it returns all possible loggers.
function getLoggerLevel {
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
# Usage: loadVMs
function loadVMs {
  curl -X POST --data '{
    "jsonrpc":"2.0",
    "id"     :1,
    "method" :"admin.loadVMs"
  }' -H 'content-type:application/json;' "${AVALANCHE_PUBLIC_API}ext/admin"
}

# Writes a profile of mutex statistics to lock.profile.
# Usage: lockProfile
function lockProfile {
  curl -X POST --data '{
    "jsonrpc":"2.0",
    "id"     :1,
    "method" :"admin.lockProfile"
  }' -H 'content-type:application/json;' "${AVALANCHE_PUBLIC_API}ext/admin"
}

# Writes a memory profile of the to mem.profile.
# Usage: memoryProfile
function memoryProfile {
  curl -X POST --data '{
    "jsonrpc":"2.0",
    "id"     :1,
    "method" :"admin.memoryProfile"
  }' -H 'content-type:application/json;' "${AVALANCHE_PUBLIC_API}ext/admin"
}

# Sets log and display levels of loggers.
# Usage: setLoggerLevel <loggerName> <logLevel> <displayLevel>
# <loggerName> is the logger's name to be changed. This is an optional parameter. If not specified, it changes all possible loggers.
# <logLevel> is the log level of written logs, can be omitted.
# <displayLevel> is the log level of displayed logs, can be omitted.
function setLoggerLevel {
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
# Usage: startCPUProfiler
function startCPUProfiler {
  curl -X POST --data '{
    "jsonrpc":"2.0",
    "id"     :1,
    "method" :"admin.startCPUProfiler"
  }' -H 'content-type:application/json;' "${AVALANCHE_PUBLIC_API}ext/admin"
}

# Stop the CPU profile that was previously started.
# Usage: stopCPUProfiler
function stopCPUProfiler {
  curl -X POST --data '{
    "jsonrpc":"2.0",
    "id"     :1,
    "method" :"admin.stopCPUProfiler"
  }' -H 'content-type:application/json;' "${AVALANCHE_PUBLIC_API}ext/admin"
}

# Info

# Given a blockchain’s alias, get its ID. 
# Usage: getBlockchainID <alias>
# <alias> is the blockchain’s alias.
function getBlockchainID {
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
# Usage: getNetworkID
function getNetworkID {
  curl -X POST --data '{
    "jsonrpc":"2.0",
    "id"     :1,
    "method" :"info.getNetworkID"
  }' -H 'content-type:application/json;' "${AVALANCHE_PUBLIC_API}ext/info"
}

# Get the name of the network this node is participating in.
# Usage: getNetworkName
function getNetworkName {
  curl -X POST --data '{
    "jsonrpc":"2.0",
    "id"     :1,
    "method" :"info.getNetworkName"
  }' -H 'content-type:application/json;' "${AVALANCHE_PUBLIC_API}ext/info"
}

# Get the ID of this node.
# Usage: getNodeID
function getNodeID {
  curl -X POST --data '{
    "jsonrpc":"2.0",
    "id"     :1,
    "method" :"info.getNodeID"
  }' -H 'content-type:application/json;' "${AVALANCHE_PUBLIC_API}ext/info"
}

#Get the IP of this node.
# Usage: getNodeIP
function getNodeIP {
  curl -X POST --data '{
    "jsonrpc":"2.0",
    "id"     :1,
    "method" :"info.getNodeIP"
  }' -H 'content-type:application/json;' "${AVALANCHE_PUBLIC_API}ext/info"
}

# Get the version of this node.
# Usage: getNodeVersion
function getNodeVersion {
  curl -X POST --data '{
    "jsonrpc":"2.0",
    "id"     :1,
    "method" :"info.getNodeVersion"
  }' -H 'content-type:application/json;' "${AVALANCHE_PUBLIC_API}ext/info"
}

# Get the virtual machines installed on this node.
# Usage: getVMs
function getVMs {
  curl -X POST --data '{
    "jsonrpc":"2.0",
    "id"     :1,
    "method" :"info.getVMs"
  }' -H 'content-type:application/json;' "${AVALANCHE_PUBLIC_API}ext/info"
}

# Check whether a given chain is done bootstrapping
# Usage: isBootstrapped <chain>
# <chain> is the ID or alias of a chain.
function isBootstrapped {
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
# Usage: peers <nodeIDs>
# TODO - correctly pass in array of nodeIDs
# <nodeIDs> is an optional parameter to specify what NodeID's descriptions should be returned. 
# If this parameter is left empty, descriptions for all active connections will be returned. 
# If the node is not connected to a specified nodeID, it will be omitted from the response.
function peers {
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
# Usage: getTxFee
function getTxFee {
  curl -X POST --data '{
    "jsonrpc":"2.0",
    "id"     :1,
    "method" :"info.getTxFee"
  }' -H 'content-type:application/json;' "${AVALANCHE_PUBLIC_API}ext/info"
}

# Returns the network's observed uptime of this node.
# Usage: uptime
function uptime {
  curl -X POST --data '{
    "jsonrpc":"2.0",
    "id"     :1,
    "method" :"info.uptime"
  }' -H 'content-type:application/json;' "${AVALANCHE_PUBLIC_API}ext/info"
}
