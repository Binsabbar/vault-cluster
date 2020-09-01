cd vault && docker-compose down;
cd ../etcd;
for i in {1..3}; do docker-compose -f docker-compose-node-$i.yml down; done
cd ../reverse-proxy && docker-compose down
