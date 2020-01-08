```sh
# Download binaries
./scripts/bootstrap.sh -d -s -- 1.4.4 1.4.4 0.4.18
```

0. Prepare
```sh
./scripts/create-network.sh
```

1. CA-TLS
```sh
./scripts/start-ca-tls.sh

./ca/ca-tls/scripts/enroll-admin.sh
./ca/ca-tls/scripts/register.sh
```

2. Org0(orderer organization) CA
```sh
./scripts/start-rca-org0.sh

./ca/org0/scripts/enroll-admin.sh
./ca/org0/scripts/register.sh
```
3. Org1 CA
```sh
./scripts/start-rca-org1.sh

./ca/org1/scripts/enroll-admin.sh
./ca/org1/scripts/register.sh
```

4. Org2 CA
```sh
./scripts/start-rca-org2.sh

./ca/org2/scripts/enroll-admin.sh
./ca/org2/scripts/register.sh
```

5. Enroll org1 peers
```sh
# peer1
# 1. Copy org1 root ca cert and tls ca cert
cp ca/org1/data/crypto/ca-cert.pem orgs/org1/peer1/crypto/ca
cp ca/ca-tls/data/crypto/ca-cert.pem orgs/org1/peer1/crypto/tls-ca

# 2. Enroll msp and tls
orgs/org1/peer1/enroll-msp.sh
orgs/org1/peer1/enroll-tls.sh

# peer2
# 1. Copy root ca cert and tls ca cert
cp ca/org1/data/crypto/ca-cert.pem orgs/org1/peer2/crypto/ca
cp ca/ca-tls/data/crypto/ca-cert.pem orgs/org1/peer2/crypto/tls-ca

# 2. Enroll msp and tls
orgs/org1/peer2/enroll-msp.sh
orgs/org1/peer2/enroll-tls.sh
```

6. Enroll org1 admin
```sh
# 1. Copy root ca cert and tls ca cert
cp ca/org1/data/crypto/ca-cert.pem orgs/org1/admin/crypto/ca

# 2. Enroll msp
orgs/org1/admin/enroll-msp.sh

# 3. Copy admin cert to peer's msp/admincerts folder
cp orgs/org1/admin/crypto/admin/msp/signcerts/cert.pem orgs/org1/peer1/crypto/peer1/msp/admincerts/org1-admin-cert.pem
cp orgs/org1/admin/crypto/admin/msp/signcerts/cert.pem orgs/org1/peer2/crypto/peer2/msp/admincerts/org1-admin-cert.pem
```
> If you foget to make admincerts folder, you will get this error message: `Cannot run peer because error when setting up MSP of type bccsp from directory /etc/hyperledger/fabric/msp: administrators must be declared when no admin ou classification is set`

7. Start org1 peers
```sh
# 1. peer1
./scripts/start-org1-peer1.sh

# 2. peer2
./scripts/start-org1-peer2.sh
```

8. Enroll org2 peers
```sh
# peer1
# 1. Copy org2 root ca cert and tls ca cert
cp ca/org2/data/crypto/ca-cert.pem orgs/org2/peer1/crypto/ca
cp ca/ca-tls/data/crypto/ca-cert.pem orgs/org2/peer1/crypto/tls-ca

# 2. Enroll msp and tls
orgs/org2/peer1/enroll-msp.sh
orgs/org2/peer1/enroll-tls.sh

# peer2
# 1. Copy root ca cert and tls ca cert
cp ca/org2/data/crypto/ca-cert.pem orgs/org2/peer2/crypto/ca
cp ca/ca-tls/data/crypto/ca-cert.pem orgs/org2/peer2/crypto/tls-ca

# 2. Enroll msp and tls
orgs/org2/peer2/enroll-msp.sh
orgs/org2/peer2/enroll-tls.sh
```

9. Enroll org2 admin
```sh
# 1. Copy root ca cert and tls ca cert
cp ca/org2/data/crypto/ca-cert.pem orgs/org2/admin/crypto/ca

# 2. Enroll msp
orgs/org2/admin/enroll-msp.sh

# 3. Copy admin cert to peer's msp/admincerts folder
cp orgs/org2/admin/crypto/admin/msp/signcerts/cert.pem orgs/org2/peer1/crypto/peer1/msp/admincerts/org2-admin-cert.pem
cp orgs/org2/admin/crypto/admin/msp/signcerts/cert.pem orgs/org2/peer2/crypto/peer2/msp/admincerts/org2-admin-cert.pem
```
> If you foget to make admincerts folder, you will get this error message: `Cannot run peer because error when setting up MSP of type bccsp from directory /etc/hyperledger/fabric/msp: administrators must be declared when no admin ou classification is set`

10. Start org2 peers
```sh
# 1. peer1
./scripts/start-org2-peer1.sh

# 2. peer2
./scripts/start-org2-peer2.sh
```

11. Enroll org0 orderer1
```sh
cp ca/org0/data/crypto/ca-cert.pem orgs/org0/orderer1/crypto/ca
cp ca/ca-tls/data/crypto/ca-cert.pem orgs/org0/orderer1/crypto/tls-ca

orgs/org0/orderer1/enroll-msp.sh
orgs/org0/orderer1/enroll-tls.sh

# Enroll org0 admin
cp ca/org0/data/crypto/ca-cert.pem orgs/org0/admin/crypto/ca
orgs/org0/admin/enroll-msp.sh

# Copy org0 admin signcert to orderer1
cp orgs/org0/admin/crypto/admin/msp/signcerts/cert.pem orgs/org0/orderer1/crypto/orderer1/msp/admincerts/org0-admin-cert.pem
```

12. Copy msps to artifacts folder, generate genesis block
```sh
# If msp folder structure has not created yet, run command below first
./artifacts/generate-msp-folders.sh

# Copy org0 msp: admincerts, cacerts, tlscacerts
cp orgs/org0/orderer1/crypto/orderer1/msp/admincerts/org0-admin-cert.pem artifacts/msp/org0/admincerts/
cp orgs/org0/orderer1/crypto/orderer1/msp/cacerts/rca-org0-7054.pem artifacts/msp/org0/cacerts/
cp orgs/org0/orderer1/crypto/orderer1/tls/cacerts/ca-tls.pem artifacts/msp/org0/tlscacerts/

# Copy org1 msp: admincerts, cacerts, tlscacerts
cp orgs/org1/peer1/crypto/peer1/msp/admincerts/org1-admin-cert.pem artifacts/msp/org1/admincerts/
cp orgs/org1/peer1/crypto/peer1/msp/cacerts/rca-org1-7054.pem artifacts/msp/org1/cacerts/
cp orgs/org1/peer1/crypto/peer1/tls/cacerts/ca-tls.pem artifacts/msp/org1/tlscacerts/

# Copy org2 msp: admincerts, cacerts, tlscacerts
cp orgs/org2/peer1/crypto/peer1/msp/admincerts/org2-admin-cert.pem artifacts/msp/org2/admincerts/
cp orgs/org2/peer1/crypto/peer1/msp/cacerts/rca-org2-7054.pem artifacts/msp/org2/cacerts/
cp orgs/org2/peer1/crypto/peer1/tls/cacerts/ca-tls.pem artifacts/msp/org2/tlscacerts/

# Generate genesis block
./artifacts/generate-genesis-block.sh
```
> Command above will create msp folder structure and copy certs to `artifacts/msp` folder.

13. Start orderer
```sh
# Copy genesis block to orderer's artifacts folder
cp ./artifacts/blocks/genesis.block orgs/org0/orderer1/artifacts/

# Start orderer1-org0
docker-compose -f orgs/org0/orderer1/docker-compose.yml up -d
```

14. Start cli
```sh
# Copy channel artifacts
cp ./artifacts/blocks/channel.tx ./orgs/org1/peer1/channel-artifacts/
cp ./artifacts/blocks/channel.tx ./orgs/org1/peer2/channel-artifacts/
cp ./artifacts/blocks/channel.tx ./orgs/org2/peer1/channel-artifacts/
cp ./artifacts/blocks/channel.tx ./orgs/org2/peer2/channel-artifacts/

# Start cli
docker-compose -f ./orgs/org1/peer1/cli.yml up -d
docker-compose -f ./orgs/org1/peer2/cli.yml up -d
docker-compose -f ./orgs/org2/peer1/cli.yml up -d
docker-compose -f ./orgs/org2/peer2/cli.yml up -d
```

15. Create & join channel
```sh
# Org1
docker exec -it cli-peer1-org1 bash

# Create channel
peer channel create -c mychannel \
-f ./channel-artifacts/channel.tx \
-o orderer1-org0:7050 \
--outputBlock ./channel-artifacts/mychannel.block \
--tls \
--cafile /tmp/hyperledger/org1/peer1/tls/cacerts/ca-tls.pem

# Join channel
peer channel join -b ./channel-artifacts/mychannel.block
```

16. Copy channel block to other cli
```sh
cp orgs/org1/peer1/channel-artifacts/mychannel.block orgs/org1/peer2/channel-artifacts/
cp orgs/org1/peer1/channel-artifacts/mychannel.block orgs/org2/peer1/channel-artifacts/
cp orgs/org1/peer1/channel-artifacts/mychannel.block orgs/org2/peer2/channel-artifacts/
```

```sh
# Join other pees to channel
docker exec -it cli-peer2-org1 peer channel join -b ./channel-artifacts/mychannel.block
docker exec -it cli-peer1-org2 peer channel join -b ./channel-artifacts/mychannel.block
docker exec -it cli-peer2-org2 peer channel join -b ./channel-artifacts/mychannel.block
```

17. Install chaincode
```sh
docker exec cli-peer1-org1 peer chaincode install -n sacc -v 1.0 -p github.com/chaincode/sacc
docker exec cli-peer2-org1 peer chaincode install -n sacc -v 1.0 -p github.com/chaincode/sacc
docker exec cli-peer1-org2 peer chaincode install -n sacc -v 1.0 -p github.com/chaincode/sacc
docker exec cli-peer2-org2 peer chaincode install -n sacc -v 1.0 -p github.com/chaincode/sacc
```

18. Intantiate chaincode
```sh
docker exec -it cli-peer1-org1 bash

peer chaincode instantiate \
-C mychannel \
-n sacc \
-v 1.0 \
-o orderer1-org0:7050 \
--tls \
--cafile /tmp/hyperledger/org1/peer1/tls/cacerts/ca-tls.pem \
-c '{"Args":["a","100"]}' \
-P "OR ('org1MSP.member','org2MSP.member')"

# Chaincode health check
peer chaincode query -C mychannel -n sacc -c '{"Args":["get","a"]}'

peer chaincode invoke \
-o orderer1-org0:7050 \
--tls true \
--cafile /tmp/hyperledger/org1/peer1/tls/cacerts/ca-tls.pem \
-C mychannel \
-n sacc \
-c '{"Args":["set","a","1000"]}'
```
