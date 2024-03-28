# 베이스 이미지 설정
FROM ubuntu:latest

# 패키지 업데이트 및 wget, git 설치
RUN apt update && \
    apt install -y wget git cmake python3-pip curl iproute2 && \
    pip3 install --user conan==1.60.0 chardet

# python path 설정
ENV PATH="/root/.local/bin:${PATH}"

# Leap 다운로드 및 설치
RUN wget https://github.com/AntelopeIO/leap/releases/download/v5.0.2/leap_5.0.2_amd64.deb && \
    apt install -y ./leap_5.0.2_amd64.deb

# cdt 다운로드 및 설치
RUN wget https://github.com/AntelopeIO/cdt/releases/download/v4.0.1/cdt_4.0.1_amd64.deb && \
    apt install -y ./cdt_4.0.1_amd64.deb

# eos-systemo-contract install
RUN git clone https://github.com/eosnetworkfoundation/eos-system-contracts.git
WORKDIR /eos-system-contracts/build
RUN  cmake -DCMAKE_BUILD_TYPE=Release .. && make -j $(nproc)

# eos-evm 설치 및 세팅
WORKDIR /
RUN git clone https://github.com/eosnetworkfoundation/eos-evm.git
WORKDIR /eos-evm
RUN git submodule update --init --recursive

# compile contracts
WORKDIR /eos-evm/build
RUN  cmake .. && make -j

# install nvm, nodejs, npm
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash

SHELL ["/bin/bash", "-c"]
RUN source ~/.nvm/nvm.sh && nvm install 20

# eos-evm node genesis 파일 복사
WORKDIR /evm-node/genesis
COPY ./evm-node/genesis/genesis.json .

# entrypoint.sh 실행
COPY ./script/entrypoint.sh /

RUN chmod +x /entrypoint.sh

ENTRYPOINT /entrypoint.sh