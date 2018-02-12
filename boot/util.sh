#!/usr/bin/env bash

function getBootEnode() {
    BOOT_HOST=$(getent hosts boot | awk '{ print $1 }')
    ENODE=$(nc ${BOOT_HOST} 8080 | grep self=enode:// | awk '{ print $6 }' | sed -e 's/self=//g' | sed -e 's/@.*//g')
    echo "${ENODE}@${BOOT_HOST}:30301"  
}

function getEthAccount() {
    ETH_ACCOUNT=$(nc node 8080 | sed -e 's/"//g')
    echo "${ETH_ACCOUNT}"  
}
