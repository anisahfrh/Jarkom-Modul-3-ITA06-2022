# Jarkom-Modul-3-ITA06-2022

## <b> Anggota Kelompok: </b>
1. Anisah Farah Fadhilah - 5027201023
2. Banabil Fawazaim Muhammad - 5027201055
3. Shafira Khaerunnisa - 5027201072
---



## Soal 3, 4, 5, dan 6
Loid dan Franky menyusun peta tersebut dengan hati-hati dan teliti.

Ada beberapa kriteria yang ingin dibuat oleh Loid dan Franky, yaitu:

1. Semua client yang ada HARUS menggunakan konfigurasi IP dari DHCP Server.
2. Client yang melalui Switch1 mendapatkan range IP dari [prefix IP].1.50 - [prefix IP].1.88 dan [prefix IP].1.120 - [prefix IP].1.155 (3)
3. Client yang melalui Switch3 mendapatkan range IP dari [prefix IP].3.10 - [prefix IP].3.30 dan [prefix IP].3.60 - [prefix IP].3.85 (4)
4. Client mendapatkan DNS dari WISE dan client dapat terhubung dengan internet melalui DNS tersebut. (5)
5. Lama waktu DHCP server meminjamkan alamat IP kepada Client yang melalui Switch1 selama 5 menit sedangkan pada client yang melalui Switch3 selama 10 menit. Dengan waktu maksimal yang dialokasikan untuk peminjaman alamat IP selama 115 menit. (6)

### Penyelesaian soal 3, 4, 5, dan 6
Kami membuat konfigurasi pada `/etc/dhcp/dhcpd.conf` di node **Westalis** sebagai berikut
```
ddns-update-style none;

option domain-name "example.org";
option domain-name-servers ns1.example.org, ns2.example.org;

default-lease-time 600;
max-lease-time 7200;

log-facility local7;

subnet 192.212.2.0 netmask 255.255.255.0{
}
subnet 192.212.1.0 netmask 255.255.255.0 {
   range 192.212.1.50 192.212.1.88;         # penyelesaian soal 3
   range 192.212.1.120 192.212.1.155;       # penyelesaian soal 3
   option routers 192.212.1.1;
   option broadcast-address 192.212.1.255;
   option domain-name-servers 192.212.2.2;  # IP WISE   # penyelesaian soal 5
   default-lease-time 300;                  # penyelesaian soal 6
   max-lease-time 6900;                     # penyelesaian soal 6
}
subnet 192.212.3.0 netmask 255.255.255.0 {
   range 192.212.3.10 192.212.3.30;         # penyelesaian soal 4
   range 192.212.3.60 192.212.3.85;         # penyelesaian soal 4
   option routers 192.212.3.1;
   option broadcast-address 192.212.3.255;
   option domain-name-servers 192.212.2.2;  # IP WISE   # penyelesaian soal 5
   default-lease-time 600;                  # penyelesaian soal 6
   max-lease-time 6900;                     # penyelesaian soal 6
}
```

dan konfigurasi pada `/etc/bind/named.conf.options` di node **WISE** sebagai berikut agar client dapat terhubung ke internet (penyelesaian soal 5)
```
options {
        directory "/var/cache/bind";
        forwarders {
                192.168.122.1;
        };
        allow-query{any;};
        auth-nxdomain no;
        listen-on-v6 { any; };
};
```

**Testing**

![soal3-6_sss](https://github.com/anisahfrh/Screenshot_Jarkom/raw/main/Modul3/soal3-6_sss.jpg)

![soal3-6_garden](https://github.com/anisahfrh/Screenshot_Jarkom/raw/main/Modul3/soal3-6_garden.jpg)

![soal3-6_eden](https://github.com/anisahfrh/Screenshot_Jarkom/raw/main/Modul3/soal3-6_eden.jpg)

![soal3-6_newston](https://github.com/anisahfrh/Screenshot_Jarkom/raw/main/Modul3/soal3-6_newston.jpg)

![soal3-6_kemono](https://github.com/anisahfrh/Screenshot_Jarkom/raw/main/Modul3/soal3-6_kemono.jpg)



## Soal 7
Loid dan Franky berencana menjadikan Eden sebagai server untuk pertukaran informasi dengan alamat IP yang tetap dengan IP [prefix IP].3.13

### Penyelesaian soal 7
Kami menambah konfigurasi pada `/etc/dhcp/dhcpd.conf` di node **Westalis** sebagai berikut agar IP Eden tetap
```
host Eden {
    hardware ethernet 26:88:e7:9e:2d:08;
    fixed-address 192.212.3.13;
}
```

dan menambah konfigurasi pada `/etc/network/interfaces` (network configuration) di node **Eden** sebagai berikut agar hwaddress Eden tidak berganti saat project GNS3 dimatikan atau diexport.
```
hwaddress ether 26:88:e7:9e:2d:08
```

**Testing**

![soal7_eden](https://github.com/anisahfrh/Screenshot_Jarkom/raw/main/Modul3/soal7_eden.jpg)


