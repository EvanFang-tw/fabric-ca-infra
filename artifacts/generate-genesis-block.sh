#!/bin/bash

CURRENT_DIR=$(dirname $0)

pushd $CURRENT_DIR

../bin/configtxgen -channelID sys-channel -profile TwoOrgsOrdererGenesis -outputBlock ./blocks/genesis.block

../bin/configtxgen -profile TwoOrgsChannel -outputCreateChannelTx ./blocks/channel.tx -channelID mychannel

popd