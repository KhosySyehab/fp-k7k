# /etc/network/interfaces - IDS
auto lo
iface lo inet loopback

# Koneksi ke Switch1 (Backbone)
auto eth0
iface eth0 inet static
    address 172.16.10.100
    netmask 255.255.255.0
    gateway 172.16.10.1