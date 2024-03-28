#!/bin/bash
source ~/.nvm/nvm.sh

node --version

set -m

nodeos --data-dir=/app/data --config-dir=/app/config -c config.ini --genesis-json=/app/config/genesis.json --plugin eosio::chain_api_plugin &
# nodeos_pid=$!

sleep 3s

# setting (init) evm 
bash /script/init.sh

# set producer
bash /script/add_producer.sh

# # create genesis.json
bash /script/make_gen.sh

# sleep 3s
bash /script/fund.sh

jobs 

fg 1