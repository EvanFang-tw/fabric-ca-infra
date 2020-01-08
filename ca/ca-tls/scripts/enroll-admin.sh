#!/bin/bash

docker exec ca-tls \
fabric-ca-client enroll -d -u https://tls-ca-admin:tls-ca-adminpw@ca-tls:7054
