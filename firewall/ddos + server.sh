# 1. Reset Total
iptables -F
iptables -X
iptables -P FORWARD ACCEPT

# 2. State (Wajib)
iptables -A FORWARD -m state --state ESTABLISHED,RELATED -j ACCEPT

# 3. Block Guest & Inter-Dept (Security Layer 1)
iptables -A FORWARD -s 10.20.50.0/24 -d 10.20.0.0/16 -j DROP
iptables -A FORWARD -s 10.20.10.0/24 -d 10.20.30.0/24 -j DROP
iptables -A FORWARD -s 10.20.20.0/24 -d 10.20.30.0/24 -j DROP

# 4. DDoS Mitigation (Layer 2)
iptables -A FORWARD -p tcp --syn -d 10.20.40.3 --dport 80 -m connlimit --connlimit-above 20 --connlimit-mask 32 -j DROP

# 5. ALLOW RULES (Layer 3 - INI YANG PENTING)
# Web Server
iptables -A FORWARD -p tcp -d 10.20.40.3 --dport 80 -s 10.20.0.0/16 -j ACCEPT
# Database (Admin Only) -> KITA TARUH DISINI (ALLOW)
iptables -A FORWARD -p tcp -d 10.20.20.2 --dport 3306 -s 10.20.40.0/24 -j ACCEPT

# 6. DROP SISA (Layer 4 - BARU DI BLOCK SETELAH DI ALLOW)
# Block sisa akses ke Database (Selain Admin akan kena ini)
iptables -A FORWARD -d 10.20.20.2 -p tcp --dport 3306 -j DROP
# Block sisa akses ke Admin
iptables -A FORWARD -d 10.20.40.0/24 -j DROP

# 7. Logging
iptables -A FORWARD -j LOG --log-prefix "FIREWALL-DROP: " --log-level 4