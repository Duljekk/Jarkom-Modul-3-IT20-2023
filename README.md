# Laporan Resmi Praktikum Jaringan Komputer - Modul 3 IT 20

> Annisa Rahmapuri - 5027211018
> 

> Abdul Zaki Syahrul Rahmat - 502721120
> 

## Soal 0-1

Setelah mengalahkan Demon King, perjalanan berlanjut. Kali ini, kalian diminta untuk melakukan register domain berupa **riegel.canyon.it20.com** untuk worker Laravel dan **granz.channel.it20.com** untuk worker PHP **(0)** mengarah pada worker yang memiliki IP [prefix IP].x.1. 

1. **Lakukan konfigurasi sesuai dengan peta yang sudah diberikan.**

### Cara Pengerjaan

- Membuat konfirgurasi network pada setiap node sesuai dengan kerangka Topologi
    
    ![image](https://github.com/Duljekk/Jarkom-Modul-3-IT20-2023/assets/88900360/96ce5d3a-19e8-42e0-b69b-980342a18aca)
    
    | Node  | Kategori | Konfigurasi |
    | --- | --- | --- |
    | Aura | Router (DHCP Relay) | auto eth0
    iface eth0 inet dhcp
    
    auto eth1
    iface eth1 inet static
    	address 192.243.1.1
    	netmask 255.255.255.0
    
    auto eth2
    iface eth2 inet static
    	address 192.243.2.1
    	netmask 255.255.255.0
    
    auto eth3
    iface eth3 inet static
    	address 192.243.3.1
    	netmask 255.255.255.0
    
    auto eth4
    iface eth4 inet static
    	address 192.243.4.1
    	netmask 255.255.255.0 |
    | Himmel | DHCP Server | auto eth0
    iface eth0 inet static
    	address 192.243.1.2
    	netmask 255.255.255.0
    	gateway 192.243.1.1 |
    | Heiter | DNS Server | auto eth0
    iface eth0 inet static
    	address 192.243.1.3
    	netmask 255.255.255.0
    	gateway 192.243.1.1 |
    | Denken | Database Server | auto eth0
    iface eth0 inet static
    	address 192.243.2.2
    	netmask 255.255.255.0
    	gateway 192.243.2.1 |
    | Eisen | Load Balancer | auto eth0
    iface eth0 inet static
    	address 192.243.2.3
    	netmask 255.255.255.0
    	gateway 192.243.2.1 |
    | Frieren | Laravel Worker | auto eth0
    iface eth0 inet static
    	address 192.243.4.4
    	netmask 255.255.255.0
    	gateway 192.243.4.1 |
    | Flamme | Laravel Worker | auto eth0
    iface eth0 inet static
    	address 192.243.4.5
    	netmask 255.255.255.0
    	gateway 192.243.4.1 |
    | Fern | Laravel Worker | auto eth0
    iface eth0 inet static
    	address 192.243.4.6
    	netmask 255.255.255.0
    	gateway 192.243.4.1 |
    | Lawine | PHP Worker | auto eth0
    iface eth0 inet static
    	address 192.243.3.4
    	netmask 255.255.255.0
    	gateway 192.243.3.1 |
    | Linie | PHP Worker | auto eth0
    iface eth0 inet static
    	address 192.243.3.5
    	netmask 255.255.255.0
    	gateway 192.243.3.1 |
    | Lugner | PHP Worker | auto eth0
    iface eth0 inet static
    	address 192.243.3.6
    	netmask 255.255.255.0
    	gateway 192.243.3.1 |
    | Revolte | Client | auto eth0
    iface eth0 inet static
    	address 192.243.3.2
    	netmask 255.255.255.0
    	gateway 192.243.3.1 |
    | Richter | Client | auto eth0
    iface eth0 inet static
    	address 192.243.3.3
    	netmask 255.255.255.0
    	gateway 192.24.3.1 |
    | Sein | Client | auto eth0
    iface eth0 inet static
    	address 192.243.4.2
    	netmask 255.255.255.0
    	gateway 192.243.4.1 |
    | Stark | Client | auto eth0
    iface eth0 inet static
    	address 192.243.4.3
    	netmask 255.255.255.0
    	gateway 192.243.4.1 |
- Menjalankan command dibawah ini pada Router Aura
    
    ```bash
    iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE -s 192.243.0.0/16
    echo 'nameserver 192.168.122.1' > /etc/resolv.conf
    ```
    
- Menambahkan command dibawah ini pada seluruh node agar dapat terkoneksi internet
    
    ```bash
    echo 'nameserver 192.168.122.1' > /etc/resolv.conf
    ```
    
- Setelah berhasil untuk terhubung pada internet, buatlah register domain berupa `riegel.canyon.it20.com` untuk worker Laravel dan `granz.channel.it20.com` untuk worker PHP. Untuk worker laravel mengarah pada `Lunger` dan untuk worker PHP akan mengarah pada `Fern`. Berikut merupakan
    - Mengupdate paket dan menginstal bind9 pada sistem
        
        ```bash
        apt-get update 
        apt-get install bind9 -y
        ```
        
    - Menambahkan konfigurasi zona untuk domain **`riegel.canyon.it20.com`** dan **`granz.channel.it20.com`** dalam file **`/etc/bind/named.conf.local`**
        
        ```bash
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
        ```
        
    - Membuat direktori **`/etc/bind/jarkom`**, menyalin file **`db.local`** sebagai dasar, dan membuat file konfigurasi zona untuk domain **`riegel.canyon.it20.com`** dan `granz.channel.it20.com` di dalamnya
        
        ```bash
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
        @       IN      A       192.243.3.6     ; IP Lugner
        www     IN      CNAME   riegel.canyon.it20.com.' > /etc/bind/jarkom/riegel.canyon.it20.com
        
        cp /etc/bind/db.local /etc/bind/jarkom/granz.channel.it20.com
        
        echo '
        ; BIND data file for local loopback interface
        ;
        $TTL    604800
        @       IN      SOA     granz.channel.it20.com. root.granz.channel.it20.com. (
                                2023101001      ; Serial0-1
                                 604800 )       ; Negative Cache TTL
        ;
        @       IN      NS      granz.channel.it20.com.
        @       IN      A       192.243.3.6  ; IP Fern
        www     IN      CNAME   granz.channel.it20.com.' > /etc/bind/jarkom/granz.channel.it20.com
        ```
        
    - Restart bind9
        
        ```bash
        service bind9 restart
        ```
        

### Testing
![WhatsApp Image 2023-11-17 at 12 42 31_ad58a312](https://github.com/Duljekk/Jarkom-Modul-3-IT20-2023/assets/88900360/5dfae062-b9af-4793-bf31-99bd5475663d)
![WhatsApp Image 2023-11-17 at 12 43 36_a796e5b0](https://github.com/Duljekk/Jarkom-Modul-3-IT20-2023/assets/88900360/f4484832-424d-4e51-b7c4-53f3f961a6ba)



## Soal 13

#### Karena para petualang kehabisan uang, mereka kembali bekerja untuk mengatur riegel.canyon.yyy.com.

Semua data yang diperlukan, diatur pada Denken dan harus dapat diakses oleh Frieren, Flamme, dan Fern.

Pada soal nomor 13 ini kita perlu untuk mensetup Database Server (Node Denken) yang kemudian database tersebut perlu dapat diakses di node Frieren, Flamme, dan Fern.

### 1. Menyambungkan Node Denken sudah tersambung ke DNS Server

Langkah yang paling awal setelah kita menjalankan Node Denken adalah kita perlu menyambungkan nya dengan DNS Server. Tambahkan IP Heiter di resolv.conf Denken

```bash
echo 'nameserver 192.243.1.2' > etc/resolv.conf
```
### 2. Installasi package MariaDB
Di soal ini kita memerlukan service mariadb-server karena node ini akan digunakan sebagai database server. Install package mariadb-server, jangan lupa untuk lakukan update terlebih dahulu

```bash
apt-get update
apt-get install mariadb-server -y
service mysql start
```
Jalankan service mysql dengan script berikut
```bash
service mysql start
```
### 3. Masuk ke dalam service mySQL
Sebelum memasukkan command sql kita perlu terlebih dahulu login ke dalam mysql, eksekusi command berikut ini
```bash
mysql -u root -p
```
Untuk password defaultnya adalah : **root**     

Disini kita sudah berhasil untuk login sebagai user root pada service mysql

### 4. Lakukan Konfigurasi mySQL
Konfigurasikan mySQL untuk aplikasi Laravel yang akan digunakan dengan mengeksekusi query berikut
```sql
CREATE USER 'kelompokit20'@'%' IDENTIFIED BY 'passwordit20';
CREATE USER 'kelompokit20'@'localhost' IDENTIFIED BY 'passwordit20';
CREATE DATABASE dbkelompokit20;
GRANT ALL PRIVILEGES ON *.* TO 'kelompokit20'@'%';
GRANT ALL PRIVILEGES ON *.* TO 'kelompokit20'@'localhost';
FLUSH PRIVILEGES;
```
### 5. Lakukan Konfigurasi untuk koneksi ke Worker
Karena database perlu dapat diakses oleh Laravel Worker, ubah script pada ```/etc/mysql/my.cnf```
```bash
[mysqld]
skip-networking=0
skip-bind-address
```
Dan juga pada file ```/etc/mysql/mariadb.conf.d/50-server.cnf```
```bash
bind-address            = 0.0.0.0
```
### 6. Lakukan Testing pada Worker
Setelah semua konfigurasi selesai, kita dapat melakukan testing pada salah satu worker, disini kami menggunakan Worker Fern yang memiliki IP Address **192.243.4.1** dengan menggunakan command berikut
```bash
mariadb --host=192.243.2.1 --port=3306 --user=kelompokit20 --password=passwordit20 dbkelompokit20
```
Hasilnya adalah Worker Fern berhasil mengakses Database

## Soal 14


Default .bashrc (buat semua)

bash /root/setup.sh

bash /root/config.sh

IP Address
Heiter (DNS Server) - 192.243.1.2
Eisen (Load Balancer) - 192.243.2.2
Himmel (DHCP Server) - 192.243.1.1
Denken (Database Server) - 192.243.2.1

Frieren (Laravel Worker) - 192.243.4.3
Flamme (Laravel Worker) - 192.243.4.2
Fern (Laravel Worker) - 192.243.4.1

Lawine (PHP Worker) - 192.243.3.3
Linie (PHP Worker) - 192.243.3.2
Lugner (PHP Worker) - 192.243.3.1
