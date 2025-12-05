iptables -F
iptables -X

# Kita izinkan paket yang statusnya "ESTABLISHED" atau "RELATED". Artinya, jika Admin ping ke Google, balasan dari Google diizinkan masuk.
iptables -A FORWARD -m state --state ESTABLISHED,RELATED -j ACCEPT

# Blokir akses dari subnet 10.20.0.0/16 (semua lokal) MENUJU Admin, kecuali Admin sendiri. Logika: Admin boleh keluar, tapi orang lain tidak boleh inisiasi koneksi ke Admin.
iptables -A FORWARD -s 10.20.0.0/16 -d 10.20.40.0/24 -j DROP

# Guest tidak boleh ngobrol dengan subnet 10.20.x.x lainnya.
iptables -A FORWARD -s 10.20.50.0/24 -d 10.20.0.0/16 -j DROP

# Mahasiswa (Student) dan Akademik seringkali tidak butuh akses ke alat IoT. Kita blokir akses mereka ke Riset.
iptables -A FORWARD -s 10.20.10.0/24 -d 10.20.30.0/24 -j DROP
iptables -A FORWARD -s 10.20.20.0/24 -d 10.20.30.0/24 -j DROP

# Jika ada paket yang diblokir, kita catat biar tahu siapa pelakunya (bisa dilihat di dmesg).
iptables -A FORWARD -j LOG --log-prefix "Firewall-Dropped: "