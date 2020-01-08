#!/bin/bash

docker exec rca-org2 \
fabric-ca-client register -d --id.name peer1-org2 --id.secret peer1PW \
--id.affiliation org2 --id.type peer -u https://rca-org2:7054

docker exec rca-org2 \
fabric-ca-client register -d --id.name peer2-org2 --id.secret peer2PW \
--id.affiliation org2 --id.type peer -u https://rca-org2:7054

docker exec rca-org2 \
fabric-ca-client register -d --id.name admin-org2 --id.secret org2AdminPW \
--id.affiliation org2 --id.type admin -u https://rca-org2:7054

docker exec rca-org2 \
fabric-ca-client register -d --id.name user-org2 --id.secret org2UserPW \
--id.affiliation org2 --id.type user -u https://rca-org2:7054
