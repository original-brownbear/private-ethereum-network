#!/usr/bin/env bash

. /util.sh

cd /go-ethereum
./build/bin/geth --datadir=/ethereum/data init /ethereum/genesis.json &> /ethereum/log.out
./build/bin/bootnode --genkey=/ethereum/boot.key &>> /ethereum/log.out
./build/bin/bootnode --nodekey=/ethereum/boot.key &>> /ethereum/log.out &

while true; do
    nc -l -p 8080 -q 1 < /ethereum/log.out
done
