#!/usr/bin/env bash

cp -f ./genesis.json miner/
cp -f ./util.sh miner/
cp -f ./genesis.json boot/
cp -f ./util.sh boot/
cp -f ./genesis.json node/
cp -f ./util.sh node/

docker-compose up --build -d
