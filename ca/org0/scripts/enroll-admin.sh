#!/bin/bash

docker exec rca-org0 \
fabric-ca-client enroll -d -u https://rca-org0-admin:rca-org0-adminpw@rca-org0:7054
