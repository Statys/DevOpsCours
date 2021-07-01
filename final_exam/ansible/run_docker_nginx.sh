#!/bin/bash
sudo docker rm -f some-nginx
sudo docker run --name some-nginx -d -p 80:80 \
-v /nginx_data/config/default.conf:/etc/nginx/conf.d/default.conf \
-v /nginx_data/www/index.html:/www/index.html \
nginx:1.21.0-alpine