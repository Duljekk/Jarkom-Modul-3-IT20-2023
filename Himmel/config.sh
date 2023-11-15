echo 'INTERFACES="eth0"' > /etc/default/isc-dhcp-server

echo '
subnet '192.243.1.0' netmask '255.255.255.0' {
}

subnet '192.243.2.0' netmask '255.255.255.0' {
}

subnet '192.243.3.0' netmask '255.255.255.0' {
    range '192.243.3.16' '192.243.3.32';
    range '192.243.3.64' '192.243.3.80';
    option routers '192.243.3.1';
    option domain-name-servers '192.243.1.3';
    default-lease-time '180';
    max-lease-time '5760';
}

subnet '192.243.4.0' netmask '255.255.255.0' {
    range '192.243.4.12' '192.243.4.20';
    range '192.243.4.160' '192.243.4.168';
    option routers '192.243.4.1';
    option domain-name-servers '192.243.1.3';
    default-lease-time '720';
    max-lease-time '5760';
}
 ' > /etc/dhcp/dhcpd.conf

# TESTING ->
service isc-dhcp-server restart
service isc-dhcp-server status