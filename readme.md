0. Prepare
```sh
./scripts/create-network.sh
```

1. CA-TLS
```sh
./scripts/start-ca-tls.sh

./components/ca-tls/scripts/enroll-admin.sh
./components/ca-tls/scripts/register.sh
```

2. Org0(orderer organization) CA
```sh
./scripts/start-rca-org0.sh

./components/org0/scripts/enroll-admin.sh
./components/org0/scripts/register.sh
```
