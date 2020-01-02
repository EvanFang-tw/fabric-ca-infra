#!/bin/bash

docker exec rca-org2 \
fabric-ca-client enroll -d -u https://rca-org2-admin:rca-org2-adminpw@rca-org2:7054
