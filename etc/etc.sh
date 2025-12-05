echo "nameserver 8.8.8.8" > /etc/resolv.conf
apt update && apt install netcat-openbsd

echo "nameserver 8.8.8.8" > /etc/resolv.conf
apt update && apt install iptables -y

echo 1 > /proc/sys/net/ipv4/ip_forward