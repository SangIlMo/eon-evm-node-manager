#!/bin/bash

count=0
# 파일을 한 줄씩 읽어서 처리
while IFS= read -r line; do
    # 맨 뒤의 ',' 제거
    account=$(echo $line | sed 's/,$//' | tr -d '"')
    # cleos transfer 명령어 실행
    cleos transfer eosio eosio.evm "10.000 EOS" $account > /dev/null 2>&1

    ((count++))

    if [ $((count % 2500)) -eq 0 ]; then
        echo "Count: $count"
        sleep 1s
        # break
    fi

    if [ $count -eq 10000 ]; then
        break
    fi
done < /script/account_100k
