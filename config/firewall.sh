# /etc/network/interfaces - Firewall
auto lo
iface lo inet loopback

# Uplink ke Edge-Router
auto eth0
iface eth0 inet static
    address 172.16.1.2
    netmask 255.255.255.252
    gateway 172.16.1.1

# Downlink ke Backbone (Switch1)
auto eth1
iface eth1 inet static
    address 172.16.10.1
    netmask 255.255.255.0
    # Routing Statis ke tiap Departemen (PENTING!)
    up ip route add 10.20.10.0/24 via 172.16.10.20
    up ip route add 10.20.20.0/24 via 172.16.10.30
    up ip route add 10.20.30.0/24 via 172.16.10.40
    up ip route add 10.20.40.0/24 via 172.16.10.10
    up ip route add 10.20.50.0/24 via 172.16.10.50