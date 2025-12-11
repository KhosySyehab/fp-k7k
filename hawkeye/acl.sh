#!/bin/bash

# 1. Reset Firewall
iptables -F
iptables -X
# Set Policy default ke ACCEPT dulu agar tidak terkunci, 
# karena kita fokus pada deteksi IDS, bukan hardening server.
iptables -P FORWARD ACCEPT 

# 2. State (Wajib ada agar koneksi balasan lancar)
iptables -A FORWARD -m state --state ESTABLISHED,RELATED -j ACCEPT

# 3. ATURAN PENTING: LOGGING (Supaya kita tahu traffic lewat)
# Kita log semua paket baru (NEW) yang lewat antar subnet
iptables -A FORWARD -m state --state NEW -j LOG --log-prefix "FW-TRAFFIC: " --log-level 4

# --- CATATAN PERUBAHAN ---
# Di file lama Anda, ada baris:
# iptables -A FORWARD -s 10.20.10.0/24 -d 10.20.30.0/24 -j DROP
# BARIS ITU HARUS DIHAPUS.
# Jika dibiarkan, Student tidak bisa Nmap/SSH ke Riset.
# -------------------------

# (Opsional) Jika Anda tetap ingin memblokir Guest (sesuai best practice):
iptables -A FORWARD -s 10.20.50.0/24 -d 10.20.0.0/16 -j DROP