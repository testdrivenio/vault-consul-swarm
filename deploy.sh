#!/bin/bash


echo "Spinning up three droplets..."

for i in 1 2 3; do
  docker-machine create \
    --driver digitalocean \
    --digitalocean-region "nyc1" \
    --digitalocean-image=debian-10-x64 \
    --engine-install-url "https://releases.rancher.com/install-docker/19.03.9.sh" \
    --digitalocean-access-token $DIGITAL_OCEAN_ACCESS_TOKEN \
    node-$i;
done


echo "Initializing Swarm mode..."

docker-machine ssh node-1 -- docker swarm init --advertise-addr $(docker-machine ip node-1)


echo "Adding the nodes to the Swarm..."

TOKEN=`docker-machine ssh node-1 docker swarm join-token worker | grep token | awk '{ print $5 }'`

for i in 2 3; do
  docker-machine ssh node-$i \
    -- docker swarm join --token ${TOKEN} $(docker-machine ip node-1):2377;
done


echo "Creating networking..."

eval $(docker-machine env node-1)
docker network create -d overlay --attachable core


echo "Deploying the stack..."

docker stack deploy --compose-file=docker-compose.yml secrets
