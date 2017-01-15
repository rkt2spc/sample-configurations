#!/bin/bash

#----------------------------------------------------------------------------
# Installation
apt-get update
apt-get -y install git
apt-get -y install unzip
apt-get -y install screen

#----------------------------------------------------------------------------
# Git ignore permission changes
git config core.fileMode false