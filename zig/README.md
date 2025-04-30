# Otomatisasi Bakup
Otomatisasi yang cepat dan optiman dengan pendekatan low level menggunakan __zig Lang__

## info
- Target path : adalah path atau folder tempat data akan di simpan dari hasil bakup
- current path : adalah path yang kan di bakup


## ckelist project
- Alur program sudah lebih baik tapi belum bisa perulangan

### managemets.zig
- function __input__ = sudah bisa di guanakan
- struct __ManagemnetsBakup__ = masih perbaikan
    1. Method __onSave()__ => bisa di gunakan tapi masih untuk linux
    2. Method __cekPathTarget() => sudah bisa digunakan

Karena file terpisah Maka setiap sting tersimpan di memori __heap__ (perhaikan aliokasi memori) 

---

### jalankan program
```bash
#jalankan langsung
zig run main.zig

#jalankan | build langsung ke format executable
zig build-exe main.zig
./main.zig
```
