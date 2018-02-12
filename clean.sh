#!/usr/bin/env bash

docker-compose kill  && docker-compose rm -f -v

rm -f ./boot/genesis.json
rm -f ./miner/genesis.json
rm -f ./node/genesis.json
