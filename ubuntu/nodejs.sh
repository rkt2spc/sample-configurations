#!/bin/bash

#----------------------------------------------------------------------------
# Notice
echo "#############################################################"
echo "# Installing NodeJs                                         #"
echo "#############################################################"

#----------------------------------------------------------------------------
# Download and Run Install script
curl -sL https://deb.nodesource.com/setup_6.x | bash -
apt-get -y install nodejs
apt-get -y install build-essential

#----------------------------------------------------------------------------
# Install basic global modules
npm install -g gulp-cli
npm install -g pm2