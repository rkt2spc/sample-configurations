#!/bin/bash

#----------------------------------------------------------------------------
# Arguments
stack='nodejs,mongodb,consul,nginx,letsencrypt'

#----------------------------------------------------------------------------
# Extract Arguments
for flag in "$@"
do
    case $flag in
        -s=*|--stack=*)
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
sources_dir="${bash_dir}/technologies"

#----------------------------------------------------------------------------
# Setup common tools
chmod 700 "${sources_dir}/common-tools.sh"
( source "${sources_dir}/common-tools.sh" )

#----------------------------------------------------------------------------
# Split stack to array
IFS=',' read -r -a technologies <<< "$stack"
for tech in "${technologies[@]}"
do
    case $tech in
        nodejs|mongodb|consul|nginx|letsencrypt)
            chmod 700 "${sources_dir}/${tech}.sh"
            ( source "${sources_dir}/${tech}.sh" )
            ;;
        *)
            echo "Un-supported technology ${tech}, no setup option"
            ;;
    esac
done