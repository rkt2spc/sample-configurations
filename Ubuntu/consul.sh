#!/bin/bash

# Arguments
x32flag='false'

# Read Arguments
while getopts 'abf:v' flag; do
  case "${flag}" in
    x32) x32flag='true' ;;
    # exampleflag) files="${OPTARG}" ;;
    *) error "Unexpected option ${flag}" ;;
  esac
done

# Set Download Url
if [ $x32flag == 'true' ]; then
  DOWNLOAD_URL='https://releases.hashicorp.com/consul/0.7.2/consul_0.7.2_linux_386.zip'
else
  DOWNLOAD_URL='https://releases.hashicorp.com/consul/0.7.2/consul_0.7.2_linux_amd64.zip'
fi

# Create temporary directory for unzipping
TEMP_DIR=`mktemp -d || mktemp -d -t 'tmpdir'`
cd $TEMP_DIR

# Clean up the temp directory
function cleanup {
  rm -r $TEMP_DIR
  echo "Deleted temp working directory $TEMP_DIR"
  cd ~
}

# Register the cleanup function to be called on the EXIT signal
trap cleanup EXIT

# Download and unzip consul bundle
wget $DOWNLOAD_URL
unzip *.zip
rm *.zip

# Move unzipped bundle to path
sudo mv -fv "$TEMP_DIR"/* '/usr/local/bin'