#!/bin/sh

docker-compose up -d

# Wait for base-node to start
until [ "`curl --silent --show-error --connect-timeout 1 -I http://localhost:8080 | grep 'Content-Type'`" != "" ];
do
  echo --- sleeping for 10 seconds
  sleep 10
done

echo 'base-node is ready!'