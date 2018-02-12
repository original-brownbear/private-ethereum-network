#!/usr/bin/env bash

. /util.sh

cd /go-ethereum
./build/bin/geth --datadir=/ethereum/data init /ethereum/genesis.json
sleep 15
./build/bin/geth --datadir=/ethereum/data --bootnodes=$(getBootEnode) --mine --minerthreads=1 --etherbase=$(getEthAccount)
