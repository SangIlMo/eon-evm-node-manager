# 베이스 이미지 설정
FROM ubuntu:latest

# 패키지 업데이트 및 wget, git 설치
RUN apt update && \
    apt install -y wget git cmake python3-pip curl iproute2 && \
    pip3 install --user conan==1.60.0 chardet

# python path 설정
ENV PATH="/root/.local/bin:${PATH}"

# eos-evm-node install
WORKDIR /
RUN git clone https://github.com/eosnetworkfoundation/eos-evm-node.git
WORKDIR /eos-evm-node
RUN git submodule update --init --recursive

# eos-evm-node compile
WORKDIR /eos-evm-node/build
RUN cmake .. && make -j8

ENV PATH="/eos-evm-node/build/bin:$PATH"

# copy genesis of evm-node

# WORKDIR /
COPY <<EOF /entrypoint.sh

cd /evm-node
rm -rf log/*
# run eos-evm-node
eos-evm-node --config-dir ./config/node-config -c config.ini &
sleep 3s

# run eos-evm-rpc
eos-evm-rpc --config-dir ./config/rpc-config -c config.ini
sleep 3s

EOF

RUN chmod +x /entrypoint.sh

ENTRYPOINT /entrypoint.sh