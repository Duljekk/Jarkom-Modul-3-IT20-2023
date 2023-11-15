echo '
# auto eth0
# iface eth0 inet static
#         address 192.243.4.3
#         netmask 255.255.255.0
#         gateway 192.243.4.1

auto eth0
iface eth0 inet dhcp' > /etc/network/interfaces

# restart node 
