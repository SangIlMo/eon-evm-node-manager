cd /
# wallet init
cleos wallet create -n w123 --file w123.key
cleos wallet import -n w123 --private-key 5KQwrPbwdL6PhXujxW37FSSQZ1JiwsST4cqQzDeyXtP79zkvFD3
cleos wallet import -n w123 --private-key 5JURSKS1BrJ1TagNBw1uVSzTQL2m9eHGkjknWeZkjSt33Awtior

# activate preactivate feature
curl --data-binary '{"protocol_features_to_activate":["0ec7e080177b2c02b278d5088611686b49d739925a92d9bfcacd7fc6b74053bd"]}' http://127.0.0.1:8888/v1/producer/schedule_protocol_feature_activations
sleep 5s

# deploy boot contract
cleos set contract eosio /eos-system-contracts/build/contracts/eosio.boot
sleep 2s

# activate other protocol features
cleos push action eosio activate '["f0af56d2c5a48d60a4a5b5c903edfb7db3a736a94ed589d0b797df33ff9d3e1d"]' -p eosio 
cleos push action eosio activate '["e0fb64b1085cc5538970158d05a009c24e276fb94e1a0bf6a528b48fbc4ff526"]' -p eosio
cleos push action eosio activate '["d528b9f6e9693f45ed277af93474fd473ce7d831dae2180cca35d907bd10cb40"]' -p eosio
cleos push action eosio activate '["c3a6138c5061cf291310887c0b5c71fcaffeab90d5deb50d3b9e687cead45071"]' -p eosio 
cleos push action eosio activate '["bcd2a26394b36614fd4894241d3c451ab0f6fd110958c3423073621a70826e99"]' -p eosio
cleos push action eosio activate '["ad9e3d8f650687709fd68f4b90b41f7d825a365b02c23a636cef88ac2ac00c43"]' -p eosio
cleos push action eosio activate '["8ba52fe7a3956c5cd3a656a3174b931d3bb2abb45578befc59f283ecd816a405"]' -p eosio 
cleos push action eosio activate '["6bcb40a24e49c26d0a60513b6aeb8551d264e4717f306b81a37a5afb3b47cedc"]' -p eosio
cleos push action eosio activate '["68dcaa34c0517d19666e6b33add67351d8c5f69e999ca1e37931bc410a297428"]' -p eosio
cleos push action eosio activate '["5443fcf88330c586bc0e5f3dee10e7f63c76c00249c87fe4fbf7f38c082006b4"]' -p eosio
cleos push action eosio activate '["4fca8bd82bbd181e714e283f83e1b45d95ca5af40fb89ad3977b653c448f78c2"]' -p eosio
cleos push action eosio activate '["ef43112c6543b88db2283a2e077278c315ae2c84719a8b25f25cc88565fbea99"]' -p eosio
cleos push action eosio activate '["4a90c00d55454dc5b059055ca213579c6ea856967712a56017487886a4d4cc0f"]' -p eosio 
cleos push action eosio activate '["35c2186cc36f7bb4aeaf4487b36e57039ccf45a9136aa856a5d569ecca55ef2b"]' -p eosio
cleos push action eosio activate '["299dcb6af692324b899b39f16d5a530a33062804e41f09dc97e9f156b4476707"]' -p eosio
cleos push action eosio activate '["2652f5f96006294109b3dd0bbde63693f55324af452b799ee137a81a905eed25"]' -p eosio
cleos push action eosio activate '["1a99a59d87e06e09ec5b028a9cbb7749b4a5ad8819004365d02dc4379a8b7241"]' -p eosio

sleep 2s
# create evm account
cleos create account eosio eosio.evm EOS8kE63z4NcZatvVWY4jxYdtLg6UEA123raMGwS6QDKwpQ69eGcP EOS8kE63z4NcZatvVWY4jxYdtLg6UEA123raMGwS6QDKwpQ69eGcP
# initialize evm 
cleos set contract eosio.evm /eos-evm/build/evm_runtime
sleep 2s

cleos push action eosio.evm init "{\"chainid\":15555,\"fee_params\":{\"gas_price\":1000000000,\"miner_cut\":90000,\"ingress_bridge_fee\":\"0.0100 EOS\"}}" -p eosio.evm
cleos set account permission eosio.evm active --add-code

# create token account and create tokens
cleos create account eosio eosio.token EOS6MRyAjQq8ud7hVNYcfnVPJqcVpscN5So8BhtHuGYqET5GDW5CV EOS6MRyAjQq8ud7hVNYcfnVPJqcVpscN5So8BhtHuGYqET5GDW5CV
cleos set contract eosio.token /eos-system-contracts/build/contracts/eosio.token
sleep 2s

cleos set account permission eosio.token active --add-code
cleos push action eosio.token create '{"issuer":"eosio", "maximum_supply":"100000000000.0000 EOS"}' -p eosio.token@active
cleos push action eosio.token issue '[ "eosio", "1000000000.0000 EOS", "memo" ]' -p eosio@active

# transfer to evm... contract account
cleos transfer eosio eosio.evm "1.0000 EOS" "eosio.evm"
# transfer to 0x2787b98fc4e731d0456b3941f0b3fe2e01439961 evm account
cleos transfer eosio eosio.evm "1.0000 EOS" "0x2787b98fc4e731d0456b3941f0b3fe2e01439961"

# get account table
cleos get table eosio.evm eosio.evm account
cleos get table eosio.token eosio.evm accounts
cleos get table eosio.token eosio accounts

# add evm teser account
cleos create account eosio evmtester EOS6MRyAjQq8ud7hVNYcfnVPJqcVpscN5So8BhtHuGYqET5GDW5CV EOS6MRyAjQq8ud7hVNYcfnVPJqcVpscN5So8BhtHuGYqET5GDW5CV
cleos push action eosio.evm open '{"owner":"evmtester"}' -p evmtester