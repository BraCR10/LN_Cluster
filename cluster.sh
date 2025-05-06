#!/bin/bash

git clone https://github.com/lightningnetwork/lnd.git

export NETWORK="simnet" 

docker volume create simnet_lnd_a
docker volume create simnet_lnd_b

cd LND/docker
docker-compose  run -d --name node_a --volume simnet_lnd_a:/root/.lnd lnd

docker logs node_a

docker ps -a
docker exec -i -t node_a bash