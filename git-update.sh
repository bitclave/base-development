#!/bin/sh

pushd base-node
git checkout develop
git pull origin develop
popd

pushd base-matcher
git checkout master
git pull origin master
popd

pushd base-rt-search
git checkout master
git pull origin master
popd

pushd base-auth-frontend
git checkout master
git pull origin master
popd

pushd base-auth-sdk
git checkout master
git pull origin master
popd

pushd shepherd-backend
git checkout master
git pull origin master
popd

pushd shepherd
git checkout master
git pull origin master
popd
