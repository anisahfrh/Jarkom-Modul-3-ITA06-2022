echo "nameserver 192.168.122.1" > /etc/resolv.conf
apt-get update
apt-get install isc-dhcp-server -y
echo '
# On what interfaces should the DHCP server (dhcpd) serve DHCP requests?
#       Separate multiple interfaces with spaces, e.g. "eth0 eth1".
INTERFACES="eth0"
'> /etc/default/isc-dhcp-server

echo '
ddns-update-style none;

option domain-name "example.org";
option domain-name-servers ns1.example.org, ns2.example.org;

default-lease-time 600;
max-lease-time 7200;

log-facility local7;

subnet 192.212.2.0 netmask 255.255.255.0{
}
subnet 192.212.1.0 netmask 255.255.255.0 {
   range 192.212.1.50 192.212.1.88;
   range 192.212.1.120 192.212.1.155; 
   option routers 192.212.1.1;
   option broadcast-address 192.212.1.255;
   option domain-name-servers 192.212.2.2;
   default-lease-time 300;
   max-lease-time 6900;
}
subnet 192.212.3.0 netmask 255.255.255.0 {
   range 192.212.3.10 192.212.3.30;
   range 192.212.3.60 192.212.3.85;
   option routers 192.212.3.1;
   option broadcast-address 192.212.3.255;
   option domain-name-servers 192.212.2.2;
   default-lease-time 600;
   max-lease-time 6900;
}
host Eden {
    hardware ethernet 26:88:e7:9e:2d:08;
    fixed-address 192.212.3.13;
}
'> /etc/dhcp/dhcpd.conf
service isc-dhcp-server restart