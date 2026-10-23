# Proyek 2 — Otomasi dan Container Linux

## 1. Informasi Proyek
- **Nama modul:** Linux Backup Automation
- **Checkpoint:** P11
- **Use case:** Otomasi backup direktori menggunakan shell script.
- **Tujuan:** Mempermudah pengarsipan data dan menyediakan catatan aktivitas backup.

## 2. Struktur Direktori
- `scripts/backup.sh` — script utama backup.
- `config/backup.conf.example` — contoh konfigurasi.
- `logs/` — tempat penyimpanan log saat script dijalankan.
- `tests/test-cases.md` — dokumentasi pengujian.
- `.gitignore` — mengatur file yang tidak disertakan ke Git.

## 3. Persyaratan
- Linux dengan Bash.
- Utilitas `tar`.
- Hak akses baca pada direktori sumber dan hak akses tulis pada direktori tujuan serta log.

## 4. Cara Menjalankan

Dari direktori repository:

```bash
bash scripts/backup.sh /path/sumber /path/tujuan
```

Contoh:

```bash
bash scripts/backup.sh "$HOME/backup-test-data" "$HOME/backup-test-output"
```

Script menerima dua parameter: direktori sumber dan direktori tujuan backup.

## 5. Verifikasi

Periksa arsip yang terbentuk di direktori tujuan:

```bash
ls -lh "$HOME/backup-test-output"
```

Periksa aktivitas yang dicatat:

```bash
cat logs/backup.log
```

Validasi sintaks script:

```bash
bash -n scripts/backup.sh
```

## 6. Exit Status
- `0`: proses backup berhasil.
- `1`: proses gagal, misalnya sumber tidak tersedia atau operasi backup gagal.
- `2`: jumlah atau format parameter tidak valid.

## 7. Pengujian
Hasil pengujian dicatat dalam `tests/test-cases.md`. Pengujian mencakup satu kondisi berhasil dan minimal dua kondisi gagal. Hasil aktual diisi berdasarkan eksekusi pada lingkungan Linux yang digunakan.

## 8. Cleanup

Hapus hanya direktori pengujian yang dibuat khusus untuk proyek ini:

```bash
rm -rf "$HOME/backup-test-data" "$HOME/backup-test-output"
rm -f "$HOME/backup-test-tujuan-file"
```

Jangan menjalankan cleanup pada direktori yang berisi data penting.

## 9. Rollback dan Pemulihan

Arsip backup yang berhasil dibuat dapat diperiksa menggunakan:

```bash
tar -tzf /path/ke/arsip-backup.tar.gz
```

Untuk memulihkan data, buat direktori pemulihan terpisah terlebih dahulu, kemudian ekstrak arsip ke direktori tersebut setelah memverifikasi isinya. Jangan langsung mengekstrak arsip ke direktori sumber karena dapat menimpa file.

Contoh pemeriksaan arsip:

```bash
mkdir -p "$HOME/backup-restore-test"
tar -xzf /path/ke/arsip-backup.tar.gz -C "$HOME/backup-restore-test"
```

Ganti `/path/ke/arsip-backup.tar.gz` dengan lokasi arsip yang benar-benar tersedia.

## 10. Batasan
- Backup dijalankan saat script dipanggil, belum terjadwal otomatis.
- Konfigurasi contoh belum dimuat otomatis oleh script.
- Pengujian dan validasi keamanan lanjutan masih dapat dikembangkan pada checkpoint berikutnya.

## 11. Kontribusi Anggota

1. **Azahra Cahya Azannah (2510501111):** Pengembangan dan integrasi shell script backup.
2. **Niken Najla Seconda (2510501126):** Dokumentasi use case, tujuan otomasi, dan petunjuk penggunaan.
3. **Nazrima Agustyani Hersanda Putri (2510501128):** Penyusunan test case dan dokumentasi hasil pengujian.
4. **Nabila Putri Purwaningrum (2510501131):** Pemeriksaan validasi input, error handling, dan konfigurasi contoh.
5. **Syafiqa Leilani Aji (2510501134):** Dokumentasi log, interpretasi hasil pengujian.

## 12. Repository dan Versi

- Repository: https://github.com/zahr33000-hash/proyek-2-otomasi-linux
- Branch: `main`
- Tag checkpoint: `P2-CHECKPOINT-P11-v01`
- Commit ID pengumpulan: lihat commit terbaru pada repository GitHub.
