#!/usr/bin/env bash

. /util.sh

cd /go-ethereum
./build/bin/geth --datadir=/ethereum/data init /ethereum/genesis.json
./build/bin/geth --datadir=/ethereum/data --bootnodes=$(getBootEnode) &

sleep 10

./build/bin/geth --exec 'personal.newAccount("foo")' attach /ethereum/data/geth.ipc > /ethereum/account

while true; do
    nc -l -p 8080 -q 1 < /ethereum/account
done

