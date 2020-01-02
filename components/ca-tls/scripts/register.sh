#!/bin/bash

docker exec ca-tls \
fabric-ca-client register -d --id.name peer1-org1 --id.secret peer1PW --id.type peer -u https://ca-tls:7054

docker exec ca-tls \
fabric-ca-client register -d --id.name peer2-org1 --id.secret peer2PW --id.type peer -u https://ca-tls:7054

docker exec ca-tls \
fabric-ca-client register -d --id.name peer1-org2 --id.secret peer1PW --id.type peer -u https://ca-tls:7054

docker exec ca-tls \
fabric-ca-client register -d --id.name peer2-org2 --id.secret peer2PW --id.type peer -u https://ca-tls:7054

docker exec ca-tls \
fabric-ca-client register -d --id.name orderer1-org0 --id.secret ordererPW --id.type orderer -u https://ca-tls:7054
