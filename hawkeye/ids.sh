nano /etc/suricata/suricata.yaml
vars:
  address-groups:
    # HOME_NET adalah subnet yang ingin kita lindungi.
    # Dalam kasus ini: Subnet Riset (10.20.30.0/24) adalah korban utama.
    # Namun amannya, masukkan semua subnet internal kampus.
    HOME_NET: "[10.20.0.0/16]"

    # EXTERNAL_NET adalah asal serangan (bisa dari internet atau subnet mahasiswa yang dianggap 'luar' bagi Riset)
    EXTERNAL_NET: "!$HOME_NET"

    