#!/bin/sh

pushd base-node
git pull origin develop
popd

pushd base-matcher
git pull origin master
popd

pushd base-rt-search
git pull origin master
popd

pushd base-auth-frontend
git pull origin master
popd

pushd base-auth-sdk
git pull origin master
popd

pushd shepherd-backend
git pull origin master
popd

pushd shepherd
git pull origin master
popd
