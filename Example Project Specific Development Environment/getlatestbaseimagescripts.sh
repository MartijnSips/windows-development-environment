#!/bin/bash

REPO=ubuntu-development-environment
BRANCH=develop

curl -LkSs https://github.com/martijnsips/${REPO}/tarball/${BRANCH} -o ${REPO}-${BRANCH}.tar.gz

gzip -d ${REPO}-${BRANCH}.tar.gz
tar -xf ${REPO}-${BRANCH}.tar

cd MartijnSips-ubuntu-development-environment-*
cp -f Vagrantfile* ..
cp -rf Ansible ..
cd ..
rm -rf MartijnSips-ubuntu-development-environment-*
rm -rf pax_global_header
rm ${REPO}-${BRANCH}.tar