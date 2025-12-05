# /etc/network/interfaces - Student-Router
auto lo
iface lo inet loopback

# Ke Switch1 (Backbone)
auto eth0
iface eth0 inet static
    address 172.16.10.20
    netmask 255.255.255.0
    gateway 172.16.10.1

# Ke LAN Mahasiswa
auto eth1
iface eth1 inet static
    address 10.20.10.1
    netmask 255.255.255.0