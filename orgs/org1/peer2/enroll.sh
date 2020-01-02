#!/bin/bash

NETWORK=ca_net
CURRENT_DIR=$(dirname $0)
CA_CLIENT_HOME=/tmp/hyperledger/fabric-ca

pushd $CURRENT_DIR

if [ ! -f crypto/ca/ca-cert.pem ]; then
  echo error: need root ca cert
  exit 1
fi

docker run \
--rm \
--network $NETWORK \
--env FABRIC_CA_CLIENT_HOME=/tmp/hyperledger/fabric-ca/peer2 \
--env FABRIC_CA_CLIENT_TLS_CERTFILES=/tmp/hyperledger/fabric-ca/ca/ca-cert.pem \
-v $(pwd)/crypto:/tmp/hyperledger/fabric-ca \
hyperledger/fabric-ca:1.4.4 \
/bin/bash -c \
"fabric-ca-client enroll -d -u https://peer2-org1:peer2PW@rca-org1:7054; chmod -R 777 /tmp/hyperledger/fabric-ca/peer2"

popd
