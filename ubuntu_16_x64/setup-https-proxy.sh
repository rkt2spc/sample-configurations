#!/bin/bash

#----------------------------------------------------------------------------
# Arguments
domains='bn-gateway.nmtuan.me'
proxy='http://localhost:8080'

#----------------------------------------------------------------------------
# Extract Arguments
for flag in "$@"
do
    case $flag in
        -d=*|--domains=*)
            domains="${flag#*=}"
            shift
            ;;
        -p=*|--proxy=*)
            proxy="${flag#*=}"
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

#----------------------------------------------------------------------------
# Install stuffs
chmod 700 "${bash_dir}/install.sh"
${bash_dir}/install.sh -stack=nginx,letsencrypt

#----------------------------------------------------------------------------
# Config SSL/TLS Certs
cat "${bash_dir}/../configs/nginx.d/acme-webroot.conf" | tee /etc/nginx/nginx.conf
nginx
letsencrypt certonly --webroot -w /var/www/html -d "${domains}"
openssl dhparam -out /etc/ssl/certs/dhparam.pem 2048

#----------------------------------------------------------------------------
# Run HTTPS NGINX
cat "${bash_dir}/../configs/nginx.d/https-proxy.conf" | tee /etc/nginx/nginx.conf
sed -i -- "s/your_domain_name/${domains//,/ }/g" /etc/nginx/nginx.conf
sed -i -- "s/your_proxy/${proxy}/g" /etc/nginx/nginx.conf
nginx -s reload

#----------------------------------------------------------------------------
# Cron Job Auto CERTs renewal
cronjob='30 2 * * 1 "letsencrypt renew --pre-hook "nginx -s quit" --post-hook "nginx"';
( crontab -l | grep -v -F "${cronjob}" ; echo "${cronjob}" ) | crontab -