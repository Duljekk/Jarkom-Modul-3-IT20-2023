echo 'nameserver 192.243.1.2
nameserver 192.168.122.1' > /etc/resolv.conf

apt-get update
apt-get install apache2-utils -y
apt-get install nginx -y
apt-get install lynx -y

service nginx start