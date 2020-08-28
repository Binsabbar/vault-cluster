# Vault on Docker Managed by Terraform
Simple Setup for Vault on Docker. The setup relies on backend storage of type `file`. It is not recommanded as it does not suppoert HA.
Suggested approach is to use `etcd` as cluster, and use it as backend storage for `Vault`.

Terraform is used to mainly manage policies and access to Vault itself. It is not used to set and revoke keys. Storing sensitive keys in Terraform is
highly discouraged.


Todos:

- [X] Enable TLS
- [X] Use Single dockersied etcd storage
- [X] Enable TLS for etcd
- [ ] Create etcd cluster
- [ ] Create vault cluster
- [ ] Create policies for vault users
- [ ] Deploy to Oracle Cloud in Private Subnet with LB