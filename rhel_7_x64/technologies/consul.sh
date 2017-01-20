#!/bin/bash

#----------------------------------------------------------------------------
# Notice
echo ""
echo ""
echo "#############################################################################"
echo "# Installing Consul                                                         #"
echo "#############################################################################"

#----------------------------------------------------------------------------
# Set Download Url
DOWNLOAD_URL='https://releases.hashicorp.com/consul/0.7.2/consul_0.7.2_linux_amd64.zip'

#----------------------------------------------------------------------------
# Save current working directory
CUR_DIR=$PWD;

#----------------------------------------------------------------------------
# Create temporary directory and cd to it
TEMP_DIR=`mktemp -d || mktemp -d -t 'tmpdir'`
cd $TEMP_DIR

#----------------------------------------------------------------------------
# Download and unzip consul bundle
wget $DOWNLOAD_URL
unzip *.zip
rm *.zip

#----------------------------------------------------------------------------
# Move unzipped bundle to path
mv -fv $TEMP_DIR/* '/usr/local/bin'

#----------------------------------------------------------------------------
# Clean up the temp directory
rm -r $TEMP_DIR
echo "Deleted temp working directory ${TEMP_DIR}"

#----------------------------------------------------------------------------
# cd back to current working directory
cd $CUR_DIR

#----------------------------------------------------------------------------
# Routing Consul DNS PORT
#----------------------------------------------------------------------------
# Routing Consul DNS TCP PORT
if [ -z "$(iptables-save -t nat | grep -- 'OUTPUT -d 127.0.0.1/32 -p tcp -m tcp --dport 53 -j REDIRECT --to-ports 8600')" ]
then
    iptables -t nat -I OUTPUT -d 127.0.0.1/32 -p tcp -m tcp --dport 53 -j REDIRECT --to-ports 8600
    echo 'Consul install: Added dns tcp redirect'
else
    echo 'Consul install: Existed dns tcp redirect'
fi

#----------------------------------------------------------------------------
# Routing Consul DNS UDP PORT
if [ -z "$(iptables-save -t nat | grep -- 'OUTPUT -d 127.0.0.1/32 -p udp -m udp --dport 53 -j REDIRECT --to-ports 8600')" ]
then
    iptables -t nat -I OUTPUT -d 127.0.0.1/32 -p udp -m udp --dport 53 -j REDIRECT --to-ports 8600
    echo 'Consul install: Added dns udp redirect'
else
    echo 'Consul install: Existed dns udp redirect'
fi