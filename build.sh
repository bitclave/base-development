#!/bin/sh

cd base-node
./gradlew clean build -x test --console=plain
docker build . -t base/node
cd ..

cd base-matcher
./gradlew clean build -x test --console=plain
docker build . -t base/matcher
cd ..

# remove dangling images
docker rmi -f $(docker images --filter "dangling=true" -q)

./start.sh