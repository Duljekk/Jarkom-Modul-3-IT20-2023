echo '
zone "riegel.canyon.it20.com" {
        type master;
        file "/etc/bind/jarkom/riegel.canyon.it20.com";
};

zone "granz.channel.it20.com" {
        type master;
        file "/etc/bind/jarkom/granz.channel.it20.com";
};

' > /etc/bind/named.conf.local

mkdir /etc/bind/jarkom
cp /etc/bind/db.local /etc/bind/jarkom/riegel.canyon.it20.com

echo '
;
; BIND data file for local loopback interface
;
$TTL    604800
@       IN      SOA     riegel.canyon.it20.com. root.riegel.canyon.it20.com. (
                        2023101001      ; Serial
                         604800         ; Refresh
                          86400         ; Retry
                        2419200         ; Expire
                         604800 )       ; Negative Cache TTL
;
@       IN      NS      riegel.canyon.it20.com.
@       IN      A       192.243.4.6     ; IP Fern
www     IN      CNAME   riegel.canyon.it20.com.' > /etc/bind/jarkom/riegel.canyon.it20.com

cp /etc/bind/db.local /etc/bind/jarkom/granz.channel.it20.com.

echo '
;
; BIND data file for local loopback interface
;
$TTL    604800
@       IN      SOA     granz.channel.it20.com. root.granz.channel.it20.com. (
                        2023101001      ; Serial
                         604800         ; Refresh
                          86400         ; Retry
                        2419200         ; Expire
                         604800 )       ; Negative Cache TTL
;
@       IN      NS      granz.channel.it20.com.
@       IN      A       192.243.3.6   ; IP Lugner
@       IN      A       192.243.2.2   ; IP Denken (Database Server)
www     IN      CNAME   granz.channel.it20.com.' > /etc/bind/jarkom/granz.channel.it20.com

service bind9 restart