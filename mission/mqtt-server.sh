# PC-Research-1

nc -l -p 1883 -k &
netstat -tulnp

# cek PC-Admin-2 (harus success)

nc -zv 10.20.30.2 1883

# cek PC-Student-2 (harus timeout)

nc -zv 10.20.30.2 1883