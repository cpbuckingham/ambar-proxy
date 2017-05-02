#!/bin/bash

echo "server {" > /etc/nginx/conf.d/default.conf
echo "  listen ${FE_EXT_PORT};" >> /etc/nginx/conf.d/default.conf
echo "  server_name ambar-fe;" >> /etc/nginx/conf.d/default.conf
echo "  client_max_body_size 1024m;" >> /etc/nginx/conf.d/default.conf
echo "  location /api/ {" >> /etc/nginx/conf.d/default.conf
echo "    proxy_pass http://webapi:8080/api/;" >> /etc/nginx/conf.d/default.conf
echo "  }" >> /etc/nginx/conf.d/default.conf
echo "  location / {" >> /etc/nginx/conf.d/default.conf
echo "    proxy_pass http://frontend:80;" >> /etc/nginx/conf.d/default.conf
echo "  }" >> /etc/nginx/conf.d/default.conf
echo "}" >> /etc/nginx/conf.d/default.conf

if [ "${API_EXT_PORT}" != "${FE_EXT_PORT}" ]
then
    echo "" >> /etc/nginx/conf.d/default.conf
    echo "server {" >> /etc/nginx/conf.d/default.conf
    echo "  listen ${API_EXT_PORT};" >> /etc/nginx/conf.d/default.conf
    echo "  server_name ambar-api;" >> /etc/nginx/conf.d/default.conf
    echo "  client_max_body_size 1024m;" >> /etc/nginx/conf.d/default.conf
    echo "  location /api/ {" >> /etc/nginx/conf.d/default.conf
    echo "    proxy_pass http://webapi:8080/api/;" >> /etc/nginx/conf.d/default.conf
    echo "  }" >> /etc/nginx/conf.d/default.conf
    echo "}" >> /etc/nginx/conf.d/default.conf
fi

echo "Starting NGINX..."

exec nginx -g "daemon off;"
