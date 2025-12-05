# 1. BERSIHKAN ATURAN LAMA
iptables -F
iptables -X
iptables -P FORWARD ACCEPT

# 2. STATEFUL INSPECTION (RULE #1 - WAJIB PALING ATAS)
# Izinkan paket balasan agar koneksi yang sah tidak terputus.
iptables -A FORWARD -m state --state ESTABLISHED,RELATED -j ACCEPT

# 3. BLOKIR GUEST & AKSES TERLARANG (SECURITY LAYER 1)
# Guest tidak boleh masuk ke jaringan internal manapun.
iptables -A FORWARD -s 10.20.50.0/24 -d 10.20.0.0/16 -j DROP
# Student & Academic dilarang akses ke IoT (Riset).
iptables -A FORWARD -s 10.20.10.0/24 -d 10.20.30.0/24 -j DROP
iptables -A FORWARD -s 10.20.20.0/24 -d 10.20.30.0/24 -j DROP

# 4. MITIGASI DDOS (SECURITY LAYER 2 - "The Punisher")
# Jika satu IP melakukan lebih dari 20 koneksi ke Web Server, tendang IP tersebut.
# (User normal aman, Hacker diblokir).
iptables -A FORWARD -p tcp --syn -d 10.20.40.3 --dport 80 -m connlimit --connlimit-above 20 --connlimit-mask 32 -j DROP

# 5. WHITELIST LAYANAN (SERVICES LAYER)
# Izinkan akses Web Server (Port 80) untuk user yang lolos rule DDoS di atas.
iptables -A FORWARD -p tcp -d 10.20.40.3 --dport 80 -s 10.20.0.0/16 -j ACCEPT

# Izinkan Admin akses Database (Port 3306).
iptables -A FORWARD -p tcp -d 10.20.20.2 --dport 3306 -s 10.20.40.0/24 -j ACCEPT

# 6. BLOKIR SISA AKSES VITAL (CLEANUP)
# Blokir sisa akses ke Database (selain Admin).
iptables -A FORWARD -d 10.20.20.2 -p tcp --dport 3306 -j DROP
# Blokir akses lain ke jaringan Admin (SSH/Ping dilarang).
iptables -A FORWARD -d 10.20.40.0/24 -j DROP

# 7. LOGGING (OPSIONAL - DEBUGGING)
# Catat paket yang dibuang (untuk monitoring).
iptables -A FORWARD -j LOG --log-prefix "FIREWALL-DROP: " --log-level 4


#cek
iptables -nvL --line-numbers