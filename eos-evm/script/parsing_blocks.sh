#!/bin/bash
if command -v jq >/dev/null 2>&1 ; then
    echo "jq found"
else
    echo "jq not found"
    apt install -y jq
fi

# 파라미터로 시작 블록과 종료 블록을 입력받음
start=$1
end=$2

# transactions 배열의 최대 길이를 저장할 변수 초기화
max_transactions_length=0
total_transactions_length=0

# 시작 블록부터 종료 블록까지 반복
for ((i=start; i<=end; i++)); do
    # cleos get block 명령어 실행 및 JSON 결과 가져오기
    block_info=$(cleos get block $i)

    # transactions 키의 배열 길이 가져오기
    transactions_length=$(echo $block_info | jq '.transactions | length')

    timestamp=$(echo $block_info | jq '.timestamp')
    # 최대 길이 갱신
    if ((transactions_length > max_transactions_length)); then
        max_transactions_length=$transactions_length
    fi

    # 총 길이 누적
    total_transactions_length=$((total_transactions_length + transactions_length))

    # 결과 출력
    echo "$timestamp Block $i Transactions Length: $transactions_length "
done

# 최대 transactions 길이 출력
echo "Maximum Transactions Length: $max_transactions_length"
echo "Total Transactions Length: $total_transactions_length"