# Himmel -> DHCP Server

echo 'nameserver 192.243.1.3' > /etc/resolv.conf

apt-get update
apt-get install -y isc-dhcp-server
dhcpd --version
