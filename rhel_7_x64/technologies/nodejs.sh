#!/bin/bash

#----------------------------------------------------------------------------
# Notice
echo ""
echo ""
echo "#############################################################################"
echo "# Installing NodeJs                                                         #"
echo "#############################################################################"

#----------------------------------------------------------------------------
# Download and Run Install script
curl -sL https://deb.nodesource.com/setup_6.x | bash -
yum -y install nodejs
yum -y install nodejs
yum -y install gcc-c++ make

#----------------------------------------------------------------------------
# Install basic global modules
npm install -g gulp-cli
npm install -g pm2