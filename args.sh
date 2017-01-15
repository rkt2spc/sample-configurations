#!/bin/bash

# Arguments
os='ubuntu';
arch='x64'

# Extract Arguments
for flag in "$@"
do
    case $flag in
        -os=*|--operation-system=*)
            os="${i#*=}"
            if [ os != 'ubuntu' && os != 'rhel' && os != 'centos' ]
            then
                echo "Unexpected option $flag, value should be one of ['ubuntu', 'rhel', 'centos'], using default value 'ubuntu' instead";
                os='ubuntu'
            fi
            shift
            ;;
        -arch=*|--architecture=*)
            arch="${i#*=}"
            if [ arch != 'x32' && arch != 'x64' ]
            then
                echo "Unexpected option $flag, value should be one of ['x32', 'x64'], using default value 'x64' instead";
                arch='x64'
            fi
            shift
            ;;
        *)
            echo "Unexpected option $flag, option have no meaning"
            ;;
    esac
done

# Print out arguments
echo "os = ${os}"
echo "arch = ${arch}"
