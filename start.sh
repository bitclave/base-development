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

docker-compose up -d

# Wait for base-node to start
until [ "`curl --silent --show-error --connect-timeout 1 -I http://localhost:8080 | grep 'Content-Type'`" != "" ];
do
  echo --- sleeping for 10 seconds
  sleep 10
done

echo 'base-node is ready!'