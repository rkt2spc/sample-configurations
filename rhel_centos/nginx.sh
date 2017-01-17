#!/bin/sh

#----------------------------------------------------------------------------
# Notice
echo ""
echo ""
echo "##################################################################################"
echo "# Installing NGINX                                                               #"
echo "##################################################################################"

#----------------------------------------------------------------------------
# Installation
echo "[nginx]
name=nginx repo
baseurl=http://nginx.org/packages/mainline/${os}/7/$basearch/
gpgcheck=0
enabled=1" | tee /etc/yum.repos.d/nginx.repo
yum update