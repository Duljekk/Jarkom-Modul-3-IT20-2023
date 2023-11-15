# server itu ip DHCP Server (Himmel)
echo '
SERVERS="192.243.1.2"
INTERFACES="eth1 eth2 eth3 eth4"
OPTIONS=' > /etc/default/isc-dhcp-relay

echo 'net.ipv4.ip_forward=1' > /etc/sysctl.conf

# TESTING ->
service isc-dhcp-relay restart