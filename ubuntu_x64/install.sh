#!/bin/bash

#----------------------------------------------------------------------------
# Arguments
stack='nodejs,mongodb,consul,nginx,letsencrypt'

#----------------------------------------------------------------------------
# Extract Arguments
for flag in "$@"
do
    case $flag in
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
bash_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
setup_dir="${bash_dir}"

#----------------------------------------------------------------------------
# Setup common tools
chmod 700 "${setup_dir}/common-tools.sh"
( source "${setup_dir}/common-tools.sh" )

#----------------------------------------------------------------------------
# Split stack to array
IFS=',' read -r -a technologies <<< "$stack"
for tech in "${technologies[@]}"
do
    case $tech in
        nodejs|mongodb|consul|nginx|letsencrypt)
            chmod 700 "${setup_dir}/${tech}.sh"
            ( source "${setup_dir}/${tech}.sh" )
            ;;
        *)
            echo "Un-supported technology ${tech}, no setup option"
            ;;
    esac
done