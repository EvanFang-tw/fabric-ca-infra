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

6. Enroll or1 admin
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
