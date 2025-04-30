#!/bin/bash

echo "$(date +'%F %T') - Securing Nginx Web Server..." >> logs/deployment.log

NGINX_CONF="/etc/nginx/nginx.conf"

# Backup
sudo cp $NGINX_CONF $NGINX_CONF.bak

# Hide Nginx version
sudo sed -i '/http {/a \    server_tokens off;' $NGINX_CONF

# Create basic SSL cert (optional but good practice)
sudo mkdir -p /etc/nginx/ssl
sudo openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
 -keyout /etc/nginx/ssl/selfsigned.key \
 -out /etc/nginx/ssl/selfsigned.crt \
 -subj "/C=IN/ST=WB/L=Kolkata/O=Ronir/CN=localhost"

# Create secure snippet
cat <<EOF | sudo tee /etc/nginx/snippets/ssl.conf > /dev/null
ssl_certificate /etc/nginx/ssl/selfsigned.crt;
ssl_certificate_key /etc/nginx/ssl/selfsigned.key;
ssl_protocols TLSv1.2 TLSv1.3;
ssl_ciphers HIGH:!aNULL:!MD5;
EOF

# Add headers and SSL to default site
DEFAULT_SITE="/etc/nginx/conf.d/default.conf"

sudo tee $DEFAULT_SITE > /dev/null <<EOF
server {
    listen 443 ssl;
    include snippets/ssl.conf;

    server_name localhost;

    add_header X-Frame-Options "SAMEORIGIN";
    add_header X-XSS-Protection "1; mode=block";
    add_header X-Content-Type-Options "nosniff";

    location / {
        root /usr/share/nginx/html;
        index index.html index.htm;
    }
}
EOF

# Redirect HTTP to HTTPS
sudo tee /etc/nginx/conf.d/redirect.conf > /dev/null <<EOF
server {
    listen 80;
    return 301 https://\$host\$request_uri;
}
EOF

# Restart Nginx
sudo nginx -t && sudo systemctl restart nginx

echo "$(date +'%F %T') - Nginx secured." >> logs/deployment.log
