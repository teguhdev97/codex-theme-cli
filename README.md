# Codex Azure

Paket kustom Windows x64 berbasis Codex 0.166.0: logo karakter terminal dan tema ungu.

Build dilakukan di GitHub Actions. Laptop pengguna tidak memerlukan Rust.
Ini versi modifikasi komunitas, bukan distribusi resmi OpenAI.

## Unduh dan jalankan

1. Buka Releases dan unduh ZIP serta SHA256SUMS.txt.
2. Periksa hash dengan Get-FileHash, lalu ekstrak ZIP.
3. Jalankan codex.exe dari folder hasil ekstraksi. Pertahankan seluruh EXE pendamping.
4. Jalankan install-theme.ps1 untuk menambahkan profil Windows Terminal.

Build awal belum diverifikasi sampai workflow berhasil. Logo sekitar 100 kolom x 54 baris; gunakan jendela lebar dan scrollback.
Paket awal berfokus pada CLI teks. Native voice runtime tidak disertakan.
Autentikasi dan konfigurasi pengguna tidak dimasukkan ke paket.

## Source

Workflow mengambil tag rust-v0.166.0 dari openai/codex, memeriksa dan menerapkan header.patch, lalu menyalin codex-logo.txt ke source. Lisensi upstream disertakan pada ZIP.
