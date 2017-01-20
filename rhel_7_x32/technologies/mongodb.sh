#!/bin/sh

#----------------------------------------------------------------------------
# Notice
echo ""
echo ""
echo "#############################################################################"
echo "# Installing MongoDB                                                        #"
echo "#############################################################################"

#----------------------------------------------------------------------------
# Installation
echo "[mongodb-org-3.4]
name=MongoDB Repository
baseurl=https://repo.mongodb.org/yum/redhat/7/mongodb-org/3.0/x86_64/
gpgcheck=1
enabled=1" | tee /etc/yum.repos.d/mongodb.repo
yum -y install mongodb-org

#----------------------------------------------------------------------------
# Run mongodb
service mongod start