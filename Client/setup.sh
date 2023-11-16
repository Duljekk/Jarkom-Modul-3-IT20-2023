cat 'nameserver 192.243.1.2' > /etc/resolv.conf

apt-get update
apt-get install lynx -y
apt-get install htop -y
apt-get install apache2-utils -y
apt-get install jq -y