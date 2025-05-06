#!/bin/bash

git clone https://github.com/lightningnetwork/lnd.git

echo -e  "\n🛑 Stopping and removing previous containers... "
docker stop btcd
docker rm btcd

docker stop node_a
docker rm node_a

export NETWORK="simnet" 

docker volume create node_a_vol
docker volume create node_b_vol

echo -e "\n🛠️  Genering new LN node and launching simnet..."
cd lnd/docker
docker-compose run -d --name node_a --volume node_a_vol:/root/.lnd lnd

echo -e"\n⏱️  Showing initial logs from node_a:"
docker logs node_a

echo -e "\n📦  Showing initial logs from btcd:"
docker logs btcd

echo -e "\n⏳ Waiting 10 seconds for services to initialize..."
sleep 10

echo -e "\n📜 Showing updated logs from node_a:"
docker logs node_a

echo -e "\n📜  Showing updated logs from btcd:"
docker logs btcd

echo -e "\n📋  Showing current status of containers:"
docker ps -a

echo -e "\n📜  Showing BTCD certificates:"
docker exec -it btcd cat /rpc/rpc.cert
docker exec -it btcd cat /rpc/rpc.key

echo -e "\n📜   Showing LND certificates:"
docker exec -it node_a cat /root/.lnd/tls.cert
docker exec -it node_a cat /root/.lnd/tls.key

sleep 5
echo -e "\n🔧  Entering bash in node_a container:"
docker exec -it node_a bash
