# FINAL SCENE

Point & click horror — jelajahi backlot studio Hollywood yang ditinggalkan sejak 1987.
Dibuat dengan Godot 4.3. Semua visual (background, vignette, kartu inventory, jumpscare)
dibuat via kode (ColorRect/Label/Tween).

## Fitur
- Splash screen animasi "LeoDev" 
- Main Menu: New Game, Load Game, Settings, Exit
- Settings: Volume, Brightness, Subtitles, Difficulty, Reset Data
- Save/Load system (auto-save per room)
- 4 ruangan + inventory + jumpscare + dialog panjang + ending typewriter
- Sistem cerita yang immersive

## Build APK via Bot Telegram

**Alur:**
1. Push project ini ke GitHub
2. Setup bot Telegram (baca bot README)
3. Telegram: `/build` → APK langsung ke chat

**Tidak perlu install Godot** — GitHub Actions yang handle build.

## Setup GitHub Actions (sudah included)

Workflow file `.github/workflows/build-android.yml` sudah ada di sini.
Cukup push ke GitHub, GitHub Actions otomatis siap build.

## Struktur
- `scripts/GameManager.gd` — autoload, simpan inventory & flag cerita
- `scripts/BaseRoom.gd` — class dasar semua ruangan (background, narasi, tombol hotspot, jumpscare)
- `scripts/Room*.gd` — logic tiap ruangan (Gate → Soundstage → Wardrobe → Screening → Ending)
- `scenes/*.tscn` — scene minimal (root Control + script)
- `.github/workflows/build-android.yml` — CI build APK otomatis

## Cara pakai (sekali di awal)
1. Buat repo GitHub baru, push semua isi folder ini ke branch `main`.
2. Buka **Settings > Actions > General** di repo, pastikan Actions diaktifkan.
3. (Opsional, biar APK ke-sign rilis) Tambah repo secrets:
   - `ANDROID_KEYSTORE_BASE64` (keystore di-base64)
   - `ANDROID_KEYSTORE_USER`
   - `ANDROID_KEYSTORE_PASSWORD`

   Kalau secrets ini dikosongin, action (`firebelley/godot-export`) otomatis pakai
   debug keystore bawaan Godot — cukup buat testing di HP sendiri.
4. Buat **Personal Access Token** (classic) dengan scope `repo` + `workflow`, ini
   yang dipakai bot Telegram buat trigger build.

## Trigger build
- Manual: tab **Actions** di repo → pilih workflow "Build Android APK" → Run workflow.
- Otomatis: lewat bot Telegram (lihat README bot), cukup ketik `/build`.

## Catatan jujur
File `.tscn` & `export_presets.cfg` di sini ditulis manual (bukan dari Godot editor),
karena environment pembuatannya nggak punya Godot editor buat testing langsung.
Kemungkinan ada penyesuaian kecil yang perlu dilakukan di Godot editor sebelum build
pertama sukses mulus (biasanya cuma masalah versi Godot atau path template export).
Kalau ada error build, cek log Actions — biasanya jelas root cause-nya.