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
        -d=*|--domain=*|--domains=*)
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
${bash_dir}/install.sh --stack=nginx,letsencrypt

#----------------------------------------------------------------------------
# Config SSL/TLS Certs
openssl dhparam -out /etc/ssl/certs/dhparam.pem 2048
cat "${bash_dir}/../configs/nginx.d/acme-webroot.conf" > /etc/nginx/nginx.conf
nginx
mkdir /var/acme
letsencrypt certonly --webroot -w /var/acme -d "${domains}"
#----------------------------------------------------------------------------
# Run HTTPS NGINX
cat "${bash_dir}/../configs/nginx.d/https-proxy.conf" > /etc/nginx/nginx.conf
sed -i -- "s~your_server_name~${domains//,/ }~g" /etc/nginx/nginx.conf
IFS=',' read -ra domains_array <<< "${domains}"
sed -i -- "s~your_ssl_certificate~/etc/letsencrypt/live/${domains_array[0]}/fullchain.pem~g" /etc/nginx/nginx.conf
sed -i -- "s~your_ssl_certificate_key~/etc/letsencrypt/live/${domains_array[0]}/privkey.pem~g" /etc/nginx/nginx.conf
sed -i -- "s~your_proxy_pass~${proxy}~g" /etc/nginx/nginx.conf
nginx -s reload

#----------------------------------------------------------------------------
# Cron Job Auto CERTs renewal
cronjob='30 2 * * 1 "letsencrypt renew --post-hook="nginx -s reload""';
( crontab -l | grep -v -F "${cronjob}" ; echo "${cronjob}" ) | crontab -
cronjob='@reboot "letsencrypt renew --post-hook="nginx -s reload""';
( crontab -l | grep -v -F "${cronjob}" ; echo "${cronjob}" ) | crontab -