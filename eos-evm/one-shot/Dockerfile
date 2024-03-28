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

# COPY ./script/entrypoint.sh /
COPY <<EOF /entrypoint.sh
#!/bin/bash

bash /app/config/init_wallet.sh

nodeos --data-dir=/app/data --config-dir=/app/config -c config.ini --genesis-json=/app/config/genesis.json

EOF

RUN chmod +x /entrypoint.sh

ENTRYPOINT /entrypoint.sh
