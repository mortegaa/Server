#!/bin/bash

mv /var/www/html/index.html /var/www/nouse
sed -i "s/autoindex off;/autoindex on;/g" /etc/nginx/nginx.conf
nginx -s reload
