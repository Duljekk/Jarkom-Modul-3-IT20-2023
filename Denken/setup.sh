echo '
nameserver 192.243.1.3 # IP DNS Server
nameserver 192.168.122.1' > /etc/resolv.conf

apt-get install mariadb-server -y
service mysql start
mysql -u root -p