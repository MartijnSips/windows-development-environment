#!/bin/bash

curl -LkSs https://github.com/martijnsips/ubuntu-development-environment/tarball/development -o ubuntu-development-environment-development.tar.gz

gzip -d ubuntu-development-environment-development.tar.gz
tar -xf ubuntu-development-environment-development.tar

cd MartijnSips-ubuntu-development-environment-*
cp -f Vagrantfile* ..
cp -rf Ansible ..
cd ..
rm -rf MartijnSips-ubuntu-development-environment-*
rm -rf pax_global_header
rm ubuntu-development-environment-development.tar