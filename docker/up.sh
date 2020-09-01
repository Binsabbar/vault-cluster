cd reverse-proxy && docker-compose up -d
cd ../etcd;
for i in {1..3}; do docker-compose -f docker-compose-node-$i.yml up -d; done
cd ../vault && docker-compose up -d;
