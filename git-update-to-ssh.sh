#!/bin/sh

git submodule init
git config submodule.base-node.url git@github.com:bitclave/base-node.git
git config submodule.base-matcher.url git@github.com:bitclave/base-matcher.git
git config submodule.base-rt-search.url git@github.com:bitclave/base-rt-search.git
git config submodule.base-auth-frontend.url git@github.com:bitclave/base-auth-frontend.git
git config submodule.base-auth-sdk.url git@github.com:bitclave/base-auth-sdk.git
git config submodule.shepherd-backend.url git@github.com:bitclave/shepherd-backend.git
git config submodule.shepherd.url git@github.com:bitclave/shepherd.git
git submodule update

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
