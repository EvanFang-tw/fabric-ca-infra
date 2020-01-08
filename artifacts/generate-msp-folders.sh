#!/bin/bash

CURRENT_DIR=$(dirname $0)

pushd $CURRENT_DIR

# org0
mkdir -p msp/org0/admincerts
mkdir msp/org0/cacerts
mkdir msp/org0/tlscacerts
mkdir msp/org0/users

# org1
mkdir -p msp/org1/admincerts
mkdir msp/org1/cacerts
mkdir msp/org1/tlscacerts
mkdir msp/org1/users

# org2
mkdir -p msp/org2/admincerts
mkdir msp/org2/cacerts
mkdir msp/org2/tlscacerts
mkdir msp/org2/users

popd