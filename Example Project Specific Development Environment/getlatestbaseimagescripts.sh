#!/bin/bash

REPO=windows-development-environment
BRANCH=develop

curl -LkSs https://github.com/martijnsips/${REPO}/tarball/${BRANCH} -o ${REPO}-${BRANCH}.tar.gz

gzip -d ${REPO}-${BRANCH}.tar.gz
tar -xf ${REPO}-${BRANCH}.tar

cd MartijnSips-windows-development-environment-*
cp -f Vagrantfile* ..
cp -rf scripts ..
cd ..
rm -rf MartijnSips-windows-development-environment-*
rm -rf pax_global_header
rm ${REPO}-${BRANCH}.tar