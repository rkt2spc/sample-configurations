#!/bin/bash

#----------------------------------------------------------------------------
# Installation
yum update
yum -y install git
yum -y install unzip
yum -y install screen

#----------------------------------------------------------------------------
# Git ignore permission changes
git config core.fileMode false