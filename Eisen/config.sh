echo '
upstream worker {
    server 192.243.4.1:8001;
    server 192.243.4.2:8002;
    server 192.243.4.3:8003;
}

server {
    listen 80;
    server_name riegel.canyon.it20.com www.riegel.canyon.it20.com;

    location / {
        proxy_pass http://worker;
    }
}' > /etc/nginx/sites-available/laravel-worker

rm /etc/nginx/sites-enabled/laravel-worker
ln -s /etc/nginx/sites-available/laravel-worker /etc/nginx/sites-enabled/laravel-worker

service nginx restart

echo '
upstream worker {
    least_conn;
    server 192.243.4.1:8001;
    server 192.243.4.2:8002;
    server 192.243.4.3:8003;
}

server {
    listen 80;
    server_name riegel.canyon.it20.com www.riegel.canyon.it20.com;

    location / {
        proxy_pass http://worker;
    }
}' > /etc/nginx/sites-available/laravel-worker

rm /etc/nginx/sites-enabled/laravel-worker
ln -s /etc/nginx/sites-available/laravel-worker /etc/nginx/sites-enabled/laravel-worker

service nginx restart