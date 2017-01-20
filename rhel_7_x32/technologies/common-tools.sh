#!/bin/bash

#----------------------------------------------------------------------------
# Notice
echo ""
echo ""
echo "#############################################################################"
echo "# Installing Common Tools                                                   #"
echo "#############################################################################"

#----------------------------------------------------------------------------
# Installation
yum update
yum -y install curl
yum -y install openssl
yum -y install git
yum -y install unzip
yum -y install screen

#----------------------------------------------------------------------------
# Git ignore permission changes
git config core.fileMode false