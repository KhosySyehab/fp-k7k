# 1. Hapus semua aturan lama (Flush)
iptables -F
iptables -X

# 2. Pondasi: Izinkan paket balasan (Stateful) - WAJIB PALING ATAS
iptables -A FORWARD -m state --state ESTABLISHED,RELATED -j ACCEPT

# 3. BLOKIR GUEST (Prioritas Tinggi!)
# Kita taruh ini di atas agar dicek duluan.
iptables -A FORWARD -s 10.20.50.0/24 -d 10.20.0.0/16 -j DROP

# 4. BLOKIR RISIKO LAIN (Student ke Riset/Database)
# Student/Akademik gaboleh iseng ke IoT (Riset)
iptables -A FORWARD -s 10.20.10.0/24 -d 10.20.30.0/24 -j DROP
iptables -A FORWARD -s 10.20.20.0/24 -d 10.20.30.0/24 -j DROP
# Blokir akses langsung ke Database (kecuali Admin nanti diizinkan di rule bawah)
iptables -A FORWARD -d 10.20.20.2 -p tcp --dport 3306 -j DROP

# 5. BARU IZINKAN LAYANAN (Whitelist)
# Izinkan Web Server (Port 80) untuk sisa user internal (Student & Academic)
# Karena Guest sudah diblokir di rule no 3, dia tidak akan sampai ke sini.
iptables -A FORWARD -p tcp -d 10.20.40.3 --dport 80 -s 10.20.0.0/16 -j ACCEPT

# Izinkan Admin akses Database
iptables -A FORWARD -p tcp -d 10.20.20.2 --dport 3306 -s 10.20.40.0/24 -j ACCEPT

# 6. SISA: Blokir akses masuk ke Admin (SSH/Ping) selain Web
iptables -A FORWARD -d 10.20.40.0/24 -j DROP