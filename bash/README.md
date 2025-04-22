# Otomatisasi-Backup-
script bash untuk otomatis bakup data penting berdasarkan jadwal yang di berikan dan otomatis mencadangkan ke directory yang di pilih

---

## note
Jalankan scrip nya atur waktu berapa lama agar bisa di-copy biarkan script nya tetap berjalan 
"masukan waktu bakup di lakukan" => ini berupa tanggal yang di masukan untuk memberitau system kapan proses bakup di lakukan __jika lama waktunya adalah hari__ , gunakan yy(tahun)--mm(month)--dd(day) untuk bakup dalam kurun waktu __jam__ atau __menit__

---

## tools yng diperlukan __Obsional__
1. __tput__  = untuk warna dan format
2. __rsync__ (di sarankan) = untuk menyalin file/folder yang berubah sahaja ( hemat sumber daya )

- install tools tools yang di pelukan
```bash
#Debian | Ubuntu
sudo apt install tput rsync
```

--- 

## cara megunakan
```bash
cd Otomatisasi-Backup-
chmod 775 main.sh
./main.sh
`
