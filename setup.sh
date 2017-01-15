#!/bin/bash

#----------------------------------------------------------------------------
# Arguments
os='ubuntu'
arch='x64'
stack='nodejs,mongodb,consul,letsencrypt'

#----------------------------------------------------------------------------
# Extract Arguments
for flag in "$@"
do
    case $flag in
        -os=*|--operation-system=*)
            os="${flag#*=}"
            if [[ $os != 'ubuntu' && $os != 'rhel' && $os != 'centos' ]]
            then
                echo "Unexpected option ${flag}, value should be one of ['ubuntu', 'rhel', 'centos'], using default value 'ubuntu' instead";
                os='ubuntu'
            fi
            shift
            ;;
        -arch=*|--architecture=*)
            arch="${flag#*=}"
            if [[ $arch != 'x32' && $arch != 'x64' ]]
            then
                echo "Unexpected option ${flag}, value should be one of ['x32', 'x64'], using default value 'x64' instead";
                arch='x64'
            fi
            shift
            ;;
        -stack=*)
            stack="${flag#*=}"
            shift
            ;;
        *)
            echo "Unexpected option ${flag}, option have no meaning"
            ;;
    esac
done

#----------------------------------------------------------------------------
# Variables
bash_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )";
setup_dir = '';

#----------------------------------------------------------------------------
# Pick setup directory base on os
if [ $os == 'ubuntu' ] 
then setup_dir = "${bash_dir}/ubuntu"
elif [ $os == 'rhel' || $os == 'centos' ]
then setup_dir = "${bash_dir}/rhel_centos"
else
    echo "Invalid operation-system option: ${os}"
    exit 1
fi

#----------------------------------------------------------------------------
# Setup common tools
chmod 700 "${setup_dir}/common-tools.sh"
( source "${setup_dir}/common-tools.sh" )

#----------------------------------------------------------------------------
# Split stack to array
IFS=',' read -r -a stack <<< "$string"
for tech in "${stack[@]}"
do
    case $tech in
        nodejs|mongodb|consul|letsencrypt)
            chmod 700 "${setup_dir}/${tech}.sh"
            ( source "${setup_dir}/${tech}.sh" )
        *)
            echo "Un-supported technology ${tech}, no setup option"
            ;;
    esac
done