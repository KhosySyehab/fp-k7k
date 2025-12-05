# /etc/network/interfaces - Edge-Router
auto lo
iface lo inet loopback

# Koneksi ke Internet (NAT Cloud)
auto eth0
iface eth0 inet dhcp
    # Mengaktifkan NAT (Masquerade) saat interface nyala
    up iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE

# Koneksi ke Firewall (Point-to-Point)
auto eth1
iface eth1 inet static
    address 172.16.1.1
    netmask 255.255.255.252
    # Routing Statis: Memberitahu Edge bahwa semua lalu lintas 10.20.x.x ada di bawah Firewall
    up ip route add 10.20.0.0/16 via 172.16.1.2