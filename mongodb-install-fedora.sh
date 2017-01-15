#!/bin/sh

sudo bash -c 'echo "[mongodb-org-3.4]
name=MongoDB Repository
baseurl=https://repo.mongodb.org/yum/redhat/7/mongodb-org/3.0/x86_64/
gpgcheck=1
enabled=1" > /etc/yum.repos.d/mongodb.repo'

sudo yum install -y mongodb-org