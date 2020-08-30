# Vault on Docker Managed by Terraform
Simple Setup for Vault on Docker. The setup relies on backend storage of type `file`. It is not recommanded as it does not suppoert HA.
Suggested approach is to use `etcd` as cluster, and use it as backend storage for `Vault`.

Terraform is used to mainly manage policies and access to Vault itself. It is not used to set and revoke keys. Storing sensitive keys in Terraform is
highly discouraged.


# Prerequisite:
* Docker version 19+
* Docker-Compose 1.26+
* Terraform 0.12+

# Setup Vault with etcd cluster:
1. `cd docker/reverse-proxy && docker-compose up -d`
2. Create certificates and keys for etcd
    1. `cd docker/etcd/certs`
    2. `terraform init`
    3. `terraform apply -auto-approve`
3. start etcd containers
    1. `cd docker/etcd`
    2. Run the following: `for i in {1..3}; do docker-compose -f docker-compose-node-$i.yml up -d; done`
4. Create certificates and keys for vault:
    1. `cd docker/vault/certs`
    2. `terraform init`
    3. `terraform apply -auto-approve`
4. start vault container:
    1. `cd docker/vault && docker-compose up -d`
5. Add the following to your `/etc/hosts`:
```
127.0.0.1 vault.internal traefik.internal etcd.internal
```
6. You can access vault via `https://vault.internal:8200` and traefik ui via: `http://traefik.internal:8080`

Todos:

- [X] Enable TLS
- [X] Use Single dockersied etcd storage
- [X] Enable TLS for etcd
- [X] Create etcd cluster
- [-] ~~Create vault cluster~~ [no longer vaild, will rely on backend cluster - etcd]
- [ ] Create policies for vault users
- [ ] Deploy to Oracle Cloud in Private Subnet with LB