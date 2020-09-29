# Deploying to Cloud

This directory contains playbooks for installing docker on target hosts then deploy and start the containers for etcd cluster and vault. 
- `ansible/docker-installation/install-docker.yml` will update the OS and install docker
- `ansible/deployment/deploy.yml` will deploy etcd as cluster to three nodes, and start vault.

**NOTE** It is important **NOT** to change the `inventory` file. Add the following to your `~/.ssh/config` in order to make it work (assuming you used `../infra/main.tf` to create your infrastructure):

```
Host jumpbox
  User ubuntu
  Hostname XXX.XXX.XXX.XXX
  IdentityFile ~/.ssh/id_rsa

Host etcd-1
  User ubuntu
  Hostname XXX.XXX.XXX.XXX
  IdentityFile ~/.ssh/id_rsa
  ProxyJump jumpbox

Host etcd-2
  User ubuntu
  Hostname XXX.XXX.XXX.XXX
  IdentityFile ~/.ssh/id_rsa
  ProxyJump jumpbox

Host etcd-3
  User ubuntu
  Hostname XXX.XXX.XXX.XXX
  IdentityFile ~/.ssh/id_rsa
  ProxyJump jumpbox

Host vault
  User ubuntu
  Hostname XXX.XXX.XXX.XXX
  IdentityFile ~/.ssh/id_rsa
  ProxyJump jumpbox
```

if you do not use `jumpbox` then just edit your `/etc/hosts` with the inventory hostnames

## Setup:
### Firewall
When oracle instances are created using their ubuntu image, there are pre-defined firewall rules that will block any incoming connections (apart from port 22) to the instance. Hence, when a port is opened you will need to also update the `iptables` rules. 

There is a role in ansible that will take care of updating the firewall rules: `ansible/deployment/firewall/tasks/main.yml` using `firewall-cmd` command.

#### Firewall Role Vars
List of ports under variable name `tcp_ports` and `udp_ports`

### Nodes Certs in Terraform
The role will generate two self-signed CA certificates. One for signing vault certificates and the other for signing etcd certificates.

Terraform files are templated and will be generated and executed by the role. Terraform state file is stored locally in directory `ansible/deployment/certs-terraform` alongside the generated certificate.

#### nodes-certs Role Vars
Basically the vars will ask for a list of nodes and clients for etcd to generated certificate for + domain name for etcd CA.

Similarly for vault, it will ask for a list of vault node to generate certificate for + domain name for vault CA.

Optionally, IPs can be added to the certificate as well.

```
---
etcd:
  ca_common_name: 
  ca_organization_name: Binsabbar's Inc
  ca_dns_names: 
    - DNS_NAME_HERE
  clients:
    - name: 
      common_name:
      dns_names:
        - DNS_NAME_HERE
      ips: # Optional
          - IP_HERE
  nodes:
    - name: 
      common_name:
      dns_names:
        - DNS_NAME_HERE
      ips: # Optional
          - IP_HERE
vault:
  ca_common_name: 
  ca_organization_name: Binsabbar's Inc
  ca_dns_names: 
    - DNS_NAME_HERE

  clients:
    - name: 
      common_name:
      dns_names:
        - DNS_NAME_HERE
      ips: # Optional
          - IP_HERE
```
### ETCD
The role will deploy to X number of nodes. It relies on two main factors:
1. The name of the hosts in the inventory under `etcd_hosts` group.
2. The order of the hosts.

The docker-compose template `ansible/deployment/deploy-etcd` will create the correct urls and node names for etcd if the two factors above are met.

The role will also setup the right docker labels for `traefik`.

#### deploy-etcd Role Vars
```
domain: your oracle VCN domain for private subnet, for example private.vaultvnc.oraclevcn.com
service_name: it is set to "{{ ansible_host }}"
service_hostname: the hostname for your etcd cluster (default to "etcd.{{ domain }}")
service_node_hostname: default to "{{ service_name }}.{{ domain }}"
```

#### Role Dependency:
This role depends on: `nodes-terraform` role.


### Vault 
The role will simply deploy a single vault to a single instance.

#### deploy-vault Role Vars:
```
domain: your oracle VCN domain for private subnet, for example private.vaultvnc.oraclevcn.com
service_hostname: the hostname for your etcd cluster (default to "vault.{{ domain }}")
etcd_hostname: The host name for etcd backend so vault connect to it. Defaulted to "etcd.{{ domain }}"
```
#### Role Dependency:
This role depends on: `nodes-terraform` role.

### Traefik
Pass it as a var a list of `tcp_ports` so it exposes them on the host.

NOTE: currenly the playbook does not use traefik network for etcd and vault deploy roles. You need to update the template for docker-compose for them and add the following:
```
networks:
  default:
    external:
      name: reverse-proxy
```
Ensure Trafik role is executed first.