echo "nameserver 192.168.122.1" > /etc/resolv.conf
apt-get update
apt-get install squid -y

echo '
acl WORKTIME time MTWHF 08:00-17:00
acl WEEKEND time SA 00:00-23:59
' > /etc/squid/acl-time.conf

echo '
loid-work.com
franky-work.com
' > /etc/squid/work-sites.acl

echo '
acl WORKSITE dstdomain "/etc/squid/work-sites.acl"
' > /etc/squid/acl-site.conf

echo '
acl GOODPORT port 443
acl CONNECT method CONNECT
' > /etc/squid/acl-port.conf

echo '
delay_pools 1
delay_class 1 1
delay_access 1 allow WEEKEND
delay_parameters 1 16000/16000
' > /etc/squid/acl-banwidth.conf

echo '
include /etc/squid/acl-time.conf
include /etc/squid/acl-site.conf
include /etc/squid/acl-port.conf
include /etc/squid/acl-banwidth.conf
http_port 8080
dns_nameservers 192.212.2.2
http_access allow WORKSITE WORKTIME
http_access deny !GOODPORT
http_access deny CONNECT !GOODPORT
http_access allow !WORKTIME
http_access deny all
visible_hostname Berlint
' > /etc/squid/squid.conf

service squid restart

