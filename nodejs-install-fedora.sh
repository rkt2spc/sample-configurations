#!/bin/sh

# Node 4.x
# curl --silent --location https://rpm.nodesource.com/setup_4.x | sudo bash -

# Node 6.x
curl --silent --location https://rpm.nodesource.com/setup_6.x | sudo bash -

# Node 7.x
# curl --silent --location https://rpm.nodesource.com/setup_7.x | sudo bash -

sudo yum -y install nodejs
sudo yum -y install gcc-c++ make



