#!/bin/bash

docker-compose -f ./config/docker-compose-services.yml up -d
echo --- wait migration to postgres 45 sec.

sleep 45
 
until [ "`curl --silent --show-error --connect-timeout 1 -I http://localhost:8545 | grep 'HTTP'`" != "" ];
do
  echo --- wait geth. sleeping for 5 seconds.
  sleep 5
done

until [ "`curl --silent --show-error --connect-timeout 1 -I http://localhost:9200 | grep 'HTTP'`" != "" ];
do
  echo --- wait elasticsearch. sleeping for 10 seconds
  sleep 10
done

until [ "`curl --silent --show-error --connect-timeout 1 http://localhost:27017 | grep ''`" != "" ];
do
  echo --- wait mongodb. sleeping for 10 seconds
  sleep 10
done

docker-compose -f ./config/docker-compose-base-node.yml up -d

until [ "`curl --silent --show-error --connect-timeout 1 -I http://localhost:8080 | grep 'HTTP'`" != "" ];
do
  echo --- wait base-node. sleeping for 10 seconds
  sleep 10
done

docker-compose -f ./config/docker-compose-shepherd-backend.yml up -d

until [ "`curl --silent --show-error --connect-timeout 1 -I http://localhost:5006 | grep 'HTTP'`" != "" ];
do
  echo --- wait shepherd-backend. sleeping for 10 seconds
  sleep 10
done

docker-compose -f ./config/docker-compose-auth-sdk.yml up -d

until [ "`curl --silent --show-error --connect-timeout 1 -I http://localhost:5003 | grep 'HTTP'`" != "" ];
do
  echo --- wait auth-sdk. sleeping for 10 seconds
  sleep 10
done

docker-compose -f ./config/docker-compose-matcher.yml up -d

docker-compose -f ./config/docker-compose-rt-search.yml up -d

until [ "`curl --silent --show-error --connect-timeout 1 -I http://localhost:5001 | grep 'HTTP'`" != "" ];
do
  echo --- wait rt-search. sleeping for 10 seconds
  sleep 10
done

docker-compose -f ./config/docker-compose-auth-frontend.yml up -d

until [ "`curl --silent --show-error --connect-timeout 1 -I http://localhost:5005 | grep 'HTTP'`" != "" ];
do
  echo --- wait auth-frontend. sleeping for 10 seconds
  sleep 10
done

docker-compose -f ./config/docker-compose-shepherd.yml up -d

until [ "`curl --silent --show-error --connect-timeout 1 -I http://localhost:5007 | grep 'HTTP'`" != "" ];
do
  echo --- wait shepherd. sleeping for 10 seconds
  sleep 10
done
