#!/bin/bash

#----------------------------------------------------------------------------
# Notice
echo ""
echo ""
echo "#############################################################################"
echo "# Installing NGINX                                                          #"
echo "#############################################################################"

#----------------------------------------------------------------------------
# Installation
curl -sL http://nginx.org/keys/nginx_signing.key | apt-key add -
echo "deb http://nginx.org/packages/mainline/ubuntu/ xenial nginx
deb-src http://nginx.org/packages/mainline/ubuntu/ xenial nginx" > /etc/apt/sources.list.d/nginx.list
apt-get update
apt-get -y install nginx