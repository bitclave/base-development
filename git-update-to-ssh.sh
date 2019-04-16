#!/bin/sh

pushd base-node
git checkout develop
git pull origin develop
git remote set-url origin git@github.com:bitclave/base-node.git
popd

pushd base-matcher
git checkout master
git pull origin master
git remote set-url origin git@github.com:bitclave/base-matcher.git
popd

pushd base-rt-search
git checkout master
git pull origin master
git remote set-url origin git@github.com:bitclave/base-rt-search.git
popd

pushd base-auth-frontend
git checkout master
git pull origin master
git remote set-url origin git@github.com:bitclave/base-auth-frontend.git
popd

pushd base-auth-sdk
git checkout master
git pull origin master
git remote set-url origin git@github.com:bitclave/base-auth-sdk.git
popd

pushd shepherd-backend
git checkout master
git pull origin master
git remote set-url origin git@github.com:bitclave/shepherd-backend.git
popd

pushd shepherd
git checkout master
git pull origin master
git remote set-url origin git@github.com:bitclave/shepherd.git
popd
