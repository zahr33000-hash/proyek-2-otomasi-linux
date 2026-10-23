## TC-01 — Backup berhasil
- Input: Direktori sumber berisi file `contoh.txt`.
- Expected: Arsip backup terbentuk dan exit status 0.
- Actual: Arsip berhasil dibuat dan exit status 0. Arsip juga berhasil diverifikasi menggunakan `tar -tzf`.
- Status: PASS

## TC-02 — Direktori sumber tidak ditemukan
- Input: Path sumber yang tidak tersedia.
- Expected: Pesan error dan exit status 1.
- Actual: Script menampilkan error bahwa direktori sumber tidak ditemukan dan exit status 1.
- Status: PASS

## TC-03 — Tujuan berupa file
- Input: Path tujuan menunjuk ke file biasa.
- Expected: Pesan error dan exit status 1.
- Actual: Script menampilkan error bahwa tujuan bukan direktori dan exit status 1.
- Status: PASS

## TC-04 — Tujuan berada di dalam sumber
- Input: Direktori tujuan berada di dalam direktori sumber.
- Expected: Script menolak operasi dan exit status 1.
- Actual: Script menampilkan pesan "Tujuan backup tidak boleh berada di dalam sumber." dan exit status 1.
- Status: PASS

## Interpretasi
Pengujian menunjukkan backup berhasil pada kondisi normal. Script juga berhasil menolak tiga kondisi gagal, yaitu sumber tidak ditemukan, tujuan berupa file, dan tujuan berada di dalam direktori sumber. Seluruh hasil sesuai dengan yang diharapkan.

Log pengujian tersedia pada `tests/sample-log.txt`.
