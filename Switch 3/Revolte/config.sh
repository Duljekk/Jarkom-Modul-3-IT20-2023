echo '
# auto eth0
# iface eth0 inet static
#         address 192.243.3.2
#         netmask 255.255.255.0
#         gateway 192.243.3.1


auto eth0
iface eth0 inet dhcp' > /etc/network/interfaces

# restart node revolte