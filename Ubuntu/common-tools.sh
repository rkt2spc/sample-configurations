#!/bin/bash

# Installation
apt-get update
apt-get install -y git
apt-get install -y unzip
apt-get install -y screen

# Ignore permission changes
git config core.fileMode false