# PC_ADMIN_1

apt update && apt install python3 -y
# Buat folder
mkdir /root/website
cd /root/website

# Buat file index.html
echo "<!DOCTYPE html><html><body><h1>Selamat Datang di Portal Kampus</h1><p>Ini adalah halaman resmi Admin.</p></body></html>" > index.html

# Cek apakah file benar-benar ada (Harus muncul index.html)
ls -l

python3 -m http.server 80 &

# PC_STUDENT_1

curl http://10.20.40.3