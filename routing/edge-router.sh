iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE

ip route add 172.16.10.0/24 via 172.16.1.2