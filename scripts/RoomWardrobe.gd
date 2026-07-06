extends BaseRoom

func _ready() -> void:
	bg_color = Color(0.05, 0.03, 0.07)
	room_title = "TRAILER WARDROBE & MAKEUP"
	narrative = "Kostum-kostum dari film yang tak pernah rilis tergantung berbaris di rak. Sebagian masih punya label cast. Sebuah kunci berkarat menggantung di tangan manekin — jari manekin itu menekuk salah arah, seolah-olah sudah menggenggam kunci itu selama bertahun-tahun. Ada jam dinding di sudut, jarumnya berputar mundur."
	super._ready()

func on_room_ready() -> void:
	GameManager.save_game()
	add_hotspot("Ambil kunci dari tangan manekin", _on_take_key)
	add_hotspot("Periksa kostum-kostum", _on_look_costumes)
	add_hotspot("Lihat daftar cast di meja makeup", _on_check_cast_list)
	add_hotspot("Buka loker yang terkunci", _on_try_locker)
	add_hotspot("Perhatikan jam dinding yang berputar mundur", _on_check_clock)
	add_hotspot("Menuju ruang pemutaran", _on_go_screening)
	add_hotspot("Kembali ke soundstage", _on_go_back)

func _on_take_key() -> void:
	play_jumpscare("TANGAN ITU BERGERAK")
	GameManager.add_item("Kunci Utama", "Kunci Utama")
	set_narrative("Kuncinya lepas dengan mudah. Sesaat, tangan manekin itu seperti menggenggam udara kosong — lalu jatuh ke samping. Di bawah manekin, kamu lihat bekas cakar di lantai. Segar. Seperti dibuat beberapa hari lalu, bukan bertahun-tahun. Manekin itu sekarang menghadap ke arah yang berbeda dari sebelumnya.")

func _on_look_costumes() -> void:
	play_jumpscare("SESUATU BERGERAK DI ANTARA KOSTUM")
	set_narrative("Setiap kostum punya label nama yang sama dijahit di dalamnya: namamu sendiri. Di jaketnya, di celanannya, di setiap jahitannya. Kostum-kostum ini dibuat khusus untuk kamu. Puluhan tahun sebelum kamu lahir. Salah satu kostum bergerak sendiri di rak, seolah baru saja dilepas dari badan seseorang yang berjalan menjauh.")

func _on_check_cast_list() -> void:
	set_narrative("Daftar cast di meja makeup. 'FINAL SCENE — Production Schedule 1987'. Di bawah namamu sebagai 'LEAD ACTOR', ada catatan: 'CALL TIME: 11:47 PM'... dan waktu itu sudah lewat tiga menit lalu. Di halaman berikutnya, tanggal produksinya bukan 1987 — tapi hari ini, tahun ini. Kedua halaman itu punya nama sutradara yang sama, tapi tanda tangannya berbeda tinta, berbeda usia kertas.")

func _on_try_locker() -> void:
	if not GameManager.has_item("Kunci Utama"):
		set_narrative("Loker ini terkunci. Kamu butuh kunci. Mungkin ada di suatu tempat...")
		return
	GameManager.set_flag("locker_opened", true)
	play_jumpscare("WAJAH DI CERMIN BUKAN WAJAHMU")
	set_narrative("Loker terbuka. Di dalamnya, rias wajah, brush, dan cermin. Di cermin itu, ada tulisan dengan lipstik merah: 'KAMU SUDAH LAMA MENUNGGU GILIRAN MU'. Tapi cermin itu tidak memantulkan wajahmu — memantulkan wajah orang lain, memakai kostum yang persis sama dengan yang kamu pakai sekarang.")

func _on_check_clock() -> void:
	set_narrative("Jam dinding itu berputar mundur, konsisten, tanpa berhenti. Kamu perhatikan lebih dekat — angka-angkanya bukan angka biasa, tapi nomor take film: 47, 46, 45... Ketika hitungannya sampai satu, sesuatu di lot ini akan selesai. Kamu tidak tahu apa. Kamu juga tidak yakin ingin tahu.")

func _on_go_screening() -> void:
	if not GameManager.has_item("Kunci Utama"):
		set_narrative("Pintu ruang pemutaran terkunci. Kamu butuh kunci.")
		return
	GameManager.goto_scene("res://scenes/RoomScreening.tscn")

func _on_go_back() -> void:
	GameManager.goto_scene("res://scenes/RoomSoundstage.tscn")