#!/bin/sh

# Node 4.x
# curl -sL https://deb.nodesource.com/setup_4.x | sudo -E bash -

# Node 6.x
curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash -

# Node 7.x
# curl -sL https://deb.nodesource.com/setup_7.x | sudo -E bash -

sudo apt-get install -y nodejs
sudo apt-get install -y build-essential

# If using Node 4.x
# sudo apt-get install -y nodejs-legacy