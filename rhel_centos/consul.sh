#!/bin/bash

#----------------------------------------------------------------------------
# Notice
echo "#############################################################"
echo "# Installing Consul                                         #"
echo "#############################################################"

#----------------------------------------------------------------------------
# Set Download Url
if [ $arch == 'x32' ]; then
  DOWNLOAD_URL='https://releases.hashicorp.com/consul/0.7.2/consul_0.7.2_linux_386.zip'
elif [ $arch == 'x64' ]; then
  DOWNLOAD_URL='https://releases.hashicorp.com/consul/0.7.2/consul_0.7.2_linux_amd64.zip'
else
  echo 'Invalid system architecture option: ${arch}'
  exit 1
fi

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
mv -fv "${TEMP_DIR}/*" '/usr/local/bin'

#----------------------------------------------------------------------------
# Clean up the temp directory
rm -r $TEMP_DIR
echo "Deleted temp working directory ${TEMP_DIR}"

#----------------------------------------------------------------------------
# cd back to current working directory
cd $CUR_DIR