# Himmel -> DHCP Server

echo '
nameserver 192.243.1.2
nameserver 192.168.122.1' > /etc/resolv.conf

apt-get update
apt-get install -y isc-dhcp-server
dhcpd --version
