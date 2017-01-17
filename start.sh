#!/bin/bash

#----------------------------------------------------------------------------
# Start MongoDB
# service mongod start

#----------------------------------------------------------------------------
# Start letsencrypt
letsencrypt 
letsencrypt certonly --standalone

#----------------------------------------------------------------------------
# Start NGINX
cat nginx.conf | tee /etc/nginx/sites-available/default
nginx