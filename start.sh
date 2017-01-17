#!/bin/bash

#----------------------------------------------------------------------------
# Arguments
domain='bn-gateway.nmtuan.me'

#----------------------------------------------------------------------------
# Extract Arguments
for flag in "$@"
do
    case $flag in
        -d=*|--domain=*)
            domain="${flag#*=}"
            shift
            ;;
        *)
            echo "Unexpected option ${flag}, option have no meaning"
            ;;
    esac
done

#----------------------------------------------------------------------------
# Start letsencrypt
letsencrypt certonly --standalone -d "${domain}"

#----------------------------------------------------------------------------
# Start NGINX
cat nginx.conf | tee /etc/nginx/sites-available/default
sed -i -- "s/your_domain_name/${domain}/g" /etc/nginx/sites-available/default
nginx