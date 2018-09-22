#!/bin/sh

pushd base-node
./gradlew clean build -x test
docker build . -t base/node
popd

pushd base-matcher
./gradlew clean build -x test
docker build . -t base/matcher
popd

# remove dangling images
docker rmi -f $(docker images --filter "dangling=true" -q)

./start.sh