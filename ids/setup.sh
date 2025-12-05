apt update && apt install suricata -y

nano /etc/suricata/suricata.yaml
vars:
  address-groups:
    # Ganti baris ini. Masukkan semua subnet internal (10.20.x.x)
    HOME_NET: "[10.20.0.0/16]"

    # EXTERNAL_NET biasanya diset sbg kebalikan dari HOME_NET
    EXTERNAL_NET: "!$HOME_NET"

nano /etc/suricata/rules/local.rules
# 1. Deteksi Ping (ICMP) - Buat ngetes kalau IDS jalan
alert icmp any any -> $HOME_NET any (msg:"IDS-ALERT: Ada Ping masuk ke Jaringan Kampus"; sid:100001; rev:1;)
# 2. Deteksi Percobaan Akses ke /etc/passwd (Web Attack Simulation)
alert tcp any any -> $HOME_NET 80 (msg:"IDS-ALERT: Indikasi Serangan Path Traversal"; content:"/etc/passwd"; sid:100002; rev:1;)
# 3. Deteksi Serangan DDoS (SYN Flood yang tadi kita lakukan)
# Jika ada lebih dari 20 paket SYN dalam 10 detik, trigger alert.
alert tcp any any -> $HOME_NET 80 (msg:"IDS-ALERT: Indikasi Serangan DoS SYN Flood"; flags:S; threshold: type both, track by_src, count 20, seconds 10; sid:100003; rev:1;)

nano /etc/suricata/suricata.yaml
# Cari bagian berikut dan pastikan diaktifkan (hilangkan tanda # jika ada)
  - /etc/suricata/rules/local.rules
# Simpan dan keluar dari editor.

# Sekarang kita jalankan Suricata untuk memantau interface eth0 (Arah ke Switch/Backbone).
# -c: file config, -i: interface monitoring
suricata -c /etc/suricata/suricata.yaml -i eth0 -D

# Cek apakah log sudah terbentuk:
tail -f /var/log/suricata/
# Harusnya ada file fast.log (ini tempat alert muncul)

# Dari PC-Student-1, ping ke Admin (10.20.40.3).
ping 10.20.40.3 -c 4