# /etc/network/interfaces - Research-Router
auto lo
iface lo inet loopback

# Ke Switch1 (Backbone)
auto eth0
iface eth0 inet static
    address 172.16.10.40
    netmask 255.255.255.0
    gateway 172.16.10.1

# Ke LAN Riset & IoT
auto eth1
iface eth1 inet static
    address 10.20.30.1
    netmask 255.255.255.0