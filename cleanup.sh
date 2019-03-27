#!/bin/sh

docker-compose -f ./config/docker-compose-services.yml down
docker-compose -f ./config/docker-compose-base-node.yml down
docker-compose -f ./config/docker-compose-matcher.yml down
docker-compose -f ./config/docker-compose-rt-search.yml down
docker-compose -f ./config/docker-compose-auth-sdk.yml down
docker-compose -f ./config/docker-compose-shepherd-backend.yml down
docker-compose -f ./config/docker-compose-auth-frontend.yml down
docker-compose -f ./config/docker-compose-shepherd-frontend.yml down

docker volume prune -f