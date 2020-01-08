#!/bin/bash

docker exec rca-org0 \
/bin/bash -c \
"fabric-ca-client enroll -d -u https://rca-org0-admin:rca-org0-adminpw@rca-org0:7054; chmod -R 777 /tmp/hyperledger/fabric-ca/admin"

# fabric-ca-client affiliation list -u https://rca-org0-admin:rca-org0-adminpw@rca-org0:7054