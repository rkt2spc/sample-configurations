#!/bin/bash

#----------------------------------------------------------------------------
# Arguments
os='ubuntu'
domain='bn-gateway.nmtuan.me'

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
# Stop NGINX
nginx -s quit

#----------------------------------------------------------------------------
# Start letsencrypt, accquire certs
if [ $os == 'ubuntu' ] 
then
    letsencrypt certonly --standalone -d "${domain}"
elif [[ $os == 'rhel' || $os == 'centos' ]]
then
    certbot certonly --standalone -d "${domain}"
else
    echo "Invalid operation-system option: ${os}"
    exit 1
fi

#----------------------------------------------------------------------------
# Edit NGINX Configuration file
cat nginx.conf > /etc/nginx/sites-available/default
sed -i -- "s/your_domain_name/${domain}/g" /etc/nginx/sites-available/default

#----------------------------------------------------------------------------
# Start NGINX
nginx

#----------------------------------------------------------------------------
# Cron Job Auto CERTs renewal
if [ $os == 'ubuntu' ] 
then
    cronjob='30 2 * * 1 "letsencrypt renew --pre-hook "nginx -s quit" --post-hook "nginx"';
    ( crontab -l | grep -v -F "${cronjob}" ; echo "${cronjob}" ) | crontab -
elif [[ $os == 'rhel' || $os == 'centos' ]]
then
    cronjob='30 2 * * 1 "certbot renew --pre-hook "nginx -s quit" --post-hook "nginx"';
    ( crontab -l | grep -v -F "${cronjob}" ; echo "${cronjob}" ) | crontab -    
else
    echo "Invalid operation-system option: ${os}"
    exit 1
fi