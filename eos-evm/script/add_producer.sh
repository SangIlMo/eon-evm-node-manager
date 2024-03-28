cleos set contract eosio /eos-system-contracts/build/contracts/eosio.bios

cleos create account eosio inita EOS8fkxkr7JiUqAqDseFnshzkfHWG1WNtDugNxjTMyfbz2VoJExju EOS8fkxkr7JiUqAqDseFnshzkfHWG1WNtDugNxjTMyfbz2VoJExju

cleos push action eosio setprods "{ \"schedule\": [{\"producer_name\": \"eosio\",\"authority\": [\"block_signing_authority_v0\", {\"threshold\": 1, \"keys\": [{\"key\": \"EOS6MRyAjQq8ud7hVNYcfnVPJqcVpscN5So8BhtHuGYqET5GDW5CV\", \"weight\":1},{\"key\": \"EOS8fkxkr7JiUqAqDseFnshzkfHWG1WNtDugNxjTMyfbz2VoJExju\", \"weight\":1}]}]}]}" -p eosio@active