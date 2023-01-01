# ec2-private-vpc-tf

POC with ec2 instance on a private vpc, with an http proxy endpoint

### update and install nginx:
```shell
sudo apt update
sudo apt upgrade
sudo apt install nginx
```

### generate self-signed ssl cert:
`sudo openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/nginx-selfsigned.key -out /etc/ssl/certs/nginx-selfsigned.crt`

### `/etc/nginx/sites-available/default` settings:
```text
server {
        listen 80 default_server;
        listen [::]:80 default_server;

        # SSL configuration
        #
        listen 443 ssl default_server;
        listen [::]:443 ssl default_server;
        include snippets/self-signed.conf;

        server_name _;

        location / {
                proxy_pass https://10.0.10.235;
                proxy_set_header Host $host;
                proxy_set_header X-Real-IP $remote_addr;
        }
}
```

### `/etc/nginx/snippets/self-signed.conf` contents:
```text
ssl_certificate /etc/ssl/certs/nginx-selfsigned.crt;
ssl_certificate_key /etc/ssl/private/nginx-selfsigned.key;
```