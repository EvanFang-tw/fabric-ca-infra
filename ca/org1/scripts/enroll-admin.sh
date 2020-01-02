#!/bin/bash

docker exec rca-org1 \
fabric-ca-client enroll -d -u https://rca-org1-admin:rca-org1-adminpw@rca-org1:7054
