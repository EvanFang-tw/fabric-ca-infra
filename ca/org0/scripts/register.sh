#!/bin/bash

docker exec rca-org0 \
fabric-ca-client register -d --id.name orderer1-org0 --id.secret ordererpw \
--id.affiliation org0 \
--id.type orderer \
-u https://rca-org0:7054

docker exec rca-org0 \
fabric-ca-client register -d --id.name admin-org0 --id.secret org0adminpw \
--id.type admin \
--id.attrs "hf.Registrar.Roles=client,hf.Registrar.Attributes=*,hf.Revoker=true,hf.GenCRL=true,admin=true:ecert,abac.init=true:ecert" \
-u https://rca-org0:7054
