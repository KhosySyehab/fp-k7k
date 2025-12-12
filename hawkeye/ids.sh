nano /etc/suricata/suricata.yaml
vars:
  address-groups:
    # HOME_NET adalah subnet yang ingin kita lindungi.
    # Dalam kasus ini: Subnet Riset (10.20.30.0/24) adalah korban utama.
    # Namun amannya, masukkan semua subnet internal kampus.
    HOME_NET: "[10.20.0.0/16]"

    # EXTERNAL_NET adalah asal serangan (bisa dari internet atau subnet mahasiswa yang dianggap 'luar' bagi Riset)
    EXTERNAL_NET: "!$HOME_NET"


  default-rule-path: /var/lib/suricata/rules
rule-files:
#  - suricata.rules
  - /etc/suricata/rules/local.rules  # <--- Pastikan path ini benar mengarah ke file rule Anda


nano /etc/suricata/rules/local.rules
alert tcp any any -> 10.20.30.2 any (msg:"MATA-ELANG: Indikasi Port Scanning (Nmap)"; flags:S; threshold: type both, track by_src, count 5, seconds 10; sid:200001; rev:1;)
alert tcp any any -> 10.20.30.2 22 (msg:"MATA-ELANG: Indikasi SSH Brute Force"; flags:S; threshold: type both, track by_src, count 5, seconds 20; sid:200002; rev:1;)
alert tcp 10.20.30.2 80 -> any any (msg:"MATA-ELANG: Terdeteksi Kebocoran Data (File Exfiltration)"; content:"CONFIDENTIAL"; nocase; sid:200003; rev:1;)

suricata -T -c /etc/suricata/suricata.yaml -v

systemctl restart suricata
# Atau jika dijalankan manual:
pkill suricata
suricata -D -c /etc/suricata/suricata.yaml -i eth0

tail -f /var/log/suricata/fast.log