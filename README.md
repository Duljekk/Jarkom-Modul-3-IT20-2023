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
Setelah semua konfigurasi selesai, kita dapat melakukan testing pada salah satu worker, disini kami menggunakan Worker Fern yang memiliki IP Address **192.243.4.1** dengan menginstallasi package mariadb-client dan menggunakan command berikut
```bash
apt-get install mariadb-client -y
```
```bash
mariadb --host=192.243.2.1 --port=3306 --user=kelompokit20 --password=passwordit20 dbkelompokit20
```
Hasilnya adalah Worker Fern berhasil mengakses Database

## Soal 14
Frieren, Flamme, dan Fern memiliki Riegel Channel sesuai dengan quest guide berikut. Jangan lupa melakukan instalasi PHP8.0 dan Composer

Di nomor 14 ini kita akan melakukan installasi aplikasi Laravel pada ketiga worker Laravel. Aplikasikan langkah-langkah dibawah ini di ketiga worker.

### 1. Koneksi ke DNS Server
Tambahkan IP Heiter di resolv.conf Denken

```bash
echo 'nameserver 192.243.1.2' > etc/resolv.conf
```

### 2. Installasi Package yang diperlukan
Ada beberapa package yang diperlukan untuk mengerjakan nomor 14 ini. Berikut adalah script untuk menginstall dan menjalankan package-package tersebut
```bash
apt-get update

# Lynx, Engine X
apt-get install lynx -y
apt-get install nginx -y

# PHP 8.0
apt-get install -y lsb-release ca-certificates apt-transport-https software-properties-common gnupg2
curl -sSLo /usr/share/keyrings/deb.sury.org-php.gpg https://packages.sury.org/php/apt.gpg
sh -c 'echo "deb [signed-by=/usr/share/keyrings/deb.sury.org-php.gpg] https://packages.sury.org/php/ $(lsb_release -sc) main" > /etc/apt/sources.list.d/php.list'

apt-get update
apt-get install php8.0-mbstring php8.0-xml php8.0-cli php8.0-common php8.0-intl php8.0-opcache php8.0-readline php8.0-mysql php8.0-fpm php8.0-curl unzip wget -y
php --version

service nginx start
service php8.0-fpm start

# Composer
wget https://getcomposer.org/download/2.0.13/composer.phar
chmod +x composer.phar
mv composer.phar /usr/bin/composer
composer -V

# Git
apt-get install git -y
```
### 3. Cloning aplikasi Laravel
Selanjutnya kita akan melakukan *git clone* pada aplikasi Laravel yang akan kita gunakan. 
```bash
git clone https://github.com/martuafernando/laravel-praktikum-jarkom.git
```
Pindahkan hasil clone tersebut kedalam folder ```/var/www/laravel-praktikum-jarkom```
```bash
mv laravel-praktikum-jarkom /var/www/laravel-praktikum-jarkom
```
### 4. Konfigurasi aplikasi Laravel
Sebelum mulai melakukan konfigurasi, kita terlebih dahulu perlu menginstall modul yang ada pada aplikasi Laravel kita menggunakan composer
```bash
cd /var/www/laravel-praktikum-jarkom
composer update
composer install
```
Setelah itu, rename file ```.env.example``` menjadi ```.env```, dan lakukan konfigurasi sebagai berikut
```bash
DB_CONNECTION=mysql
DB_HOST=192.243.2.1
DB_PORT=3306
DB_DATABASE=dbkelompokit20
DB_USERNAME=kelompokit20
DB_PASSWORD=passwordit20
```
Konfigurasi tersebut akan menghubungkan aplikasi dengan database yang sudah dibuat sebelumnya. Setelah itu, eksekusi command Laravel berikut
```bash
php artisan migrate:fresh
php artisan db:seed --class=AiringsTableSeeder
php artisan key:generate
php artisan jwt:secret
php artisan storage:link
```
Kita juga perlu melakukan konfigurasi nginx, lakukan konfigurasi seperti dibawah ini pada file ```/etc/nginx/sites-available/laravel-worker```
```nginx
server {

    listen 8001; # Ubah sesuai worker

    root /var/www/laravel-praktikum-jarkom/public;

    index index.php index.html index.htm;
    server_name _;

    location / {
            try_files $uri $uri/ /index.php?$query_string;
    }

    # pass PHP scripts to FastCGI server
    location ~ \.php$ {
    include snippets/fastcgi-php.conf;
    fastcgi_pass unix:/var/run/php/php8.0-fpm.sock;
    }

location ~ /\.ht {
            deny all;
    }

    error_log /var/log/nginx/laravel-worker_error.log;
    access_log /var/log/nginx/laravel-worker_access.log;
}
```
Kemudian lakukan symlink dan kelola akses izin
```bash
ln -s /etc/nginx/sites-available/laravel-worker /etc/nginx/sites-enabled/
chown -R www-data.www-data /var/www/laravel-praktikum-jarkom/
```
Jangan lupa untuk melakukan restart pada nginx dan PHP 8.0
```bash
service nginx restart
service php8.0-fpm start
```
### 5. Testing aplikasi
Untuk melakukan testing kita dapat menggunakan **lynx localhost:[port]** sesuai dengan Worker yang kita gunakan. Disini kami akan melakukan testing pada worker Fern dengan port 8001
```bash
lynx localhost:8001
```
Jika sudah berhasil, akan tampil tampilan berikut

## Soal 15 - 17
Pada 3 soal ini kita akan melakukan benchmarking pada client untuk aplikasi Laravel yang sudah kita buat sebelumnya

Riegel Channel memiliki beberapa endpoint yang harus ditesting sebanyak 100 request dengan 10 request/second. Tambahkan response dan hasil testing pada grimoire. 

Sebelum melakukan testing, pastikan client sudah terhubung ke DNS Server
```bash
echo 'nameserver 192.243.1.2' > etc/resolv.conf
```
Lakukan installasi juga untuk package yang diperlukan untuk benchmarking seperti Apache Benchmark dan Htop
```bash
apt-get update
apt-get install lynx -y
apt-get install htop -y
apt-get install apache2-utils -y
apt-get install jq -y
```
Untuk testing, kami disini menggunakan client Stark dan worker Fern
### 15. POST /auth/register
Pada nomor 15 kami membuat file JSON yang berisi kredensial username dan password untuk benchmarking ini yang diberi nama ```credentials.json```
```json
{
  "username": "kelompokit20",
  "password": "passwordit20"
}
```
Untuk testingnya menggunakan command berikut
```bash
ab -n 100 -c 10 -p credentials.json -T application/json http://192.243.4.1:8001/api/auth/register
```

### 16. POST /auth/login
Nomor ini juga menggunakan ```credentials.json``` yang dibuat sebelumnya, hanya endpoint api nya saja yang dirubah
```bash
ab -n 100 -c 10 -p credentials.json -T application/json http://192.243.4.1:8001/api/auth/login
```
### 17. GET /me
Untuk endpoint ini kita perlu untuk menggunakan bearer token, yang didapat dengan melakukan request POST ke endpoint di nomor sebelumnya
```bash
curl -X POST -H "Content-Type: application/json" -d @credentials.json http://192.243.4.1:8001/api/auth/login > output.txt
```
Response dari request tersebut akan disimpan di output.txt, jika berhasil maka akan tampil token yang akan kita gunakan. Perlu diperhatikan jika terjadi kegagalan ada kemungkinan server menerima terlalu banyak request sehingga kita perlu tunggu dulu beberapa saat.

Selanjutnya, masukkan token ke variabel global dengan jq
```bash
token=$(cat output.txt | jq -r '.token')
```
Kemudian jalankan command testing dibawah ini
```bash
ab -n 100 -c 10 -H "Authorization: Bearer $token" http://192.243.4.1:8001/api/me
```


- POST /auth/login **(16)**
- GET /me **(17)**






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
