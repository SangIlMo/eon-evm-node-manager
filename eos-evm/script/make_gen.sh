cd /
cleos get block 2 > /block.json
block_timestamp=$(node -e "const block=require('/block.json');console.log(block.timestamp)")
block_id=$(node -e "const block=require('/block.json');console.log(block.id)")
timestamp=$(python3 -c "from datetime import datetime; print(hex(int((datetime.strptime('$block_timestamp','%Y-%m-%dT%H:%M:%S.%f')-datetime(1970,1,1)).total_seconds())))")
genesis=$(node -e "let evm_gen=require('/evm-node/genesis/genesis.json');evm_gen['timestamp']='${timestamp}';evm_gen['mixHash']='0x${block_id}';console.log(JSON.stringify(evm_gen))")
echo $genesis > /evm-node/genesis/genesis.json
touch /success