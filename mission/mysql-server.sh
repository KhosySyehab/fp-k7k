# PC-Academic-1

nc -l -p 3306 -k &
netstat -tulnp

# cek PC-Admin-1 (harus success)

nc -zv 10.20.20.2 3306

# cek PC-Student-1 (harus timeout)

nc -zv 10.20.20.2 3306