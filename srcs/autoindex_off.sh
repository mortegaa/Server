#!/bin/bash

mv /var/www/nouse /var/www//html/index.html
sed -i "s/autoindex on;/autoindex off;/g" /etc/nginx/nginx.conf
nginx -s reload
