# Revolte -> CLient 1 Switch 3

ip a
# harsunya ip inetnya masih statis -> 192.243.3.3

echo '
# auto eth0
# iface eth0 inet static
#         address 192.243.3.3
#         netmask 255.255.255.0
#         gateway 192.243.3.1


auto eth0
iface eth0 inet dhcp' > /etc/network/interfaces

# restart node revolte

# TESTING ->
cat /etc/resolv.conf
ip a
#harusnya ke ganti ke range yang ditentuin 
