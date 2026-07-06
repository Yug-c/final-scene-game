extends BaseRoom

func _ready() -> void:
	bg_color = Color(0.04, 0.05, 0.08)
	room_title = "STUDIO GATE — FINAL SCENE LOT"
	narrative = "Gerbang berpagar rantai tergantung terbuka. Papan pudar bertuliskan 'FINAL SCENE — DITUTUP SEJAK 1987'. Tapi rantainya berkarat seolah sudah puluhan tahun, sementara gembok di sampingnya masih mengkilap seperti baru dipasang kemarin. Di balik kabut, lampu soundstage menyala sendiri."
	super._ready()
	GameManager.save_game()

func on_room_ready() -> void:
	add_hotspot("Ambil senter yang tergeletak", _on_flashlight)
	add_hotspot("Berjalan menuju soundstage", _on_enter_soundstage)
	add_hotspot("Baca pengumuman casting yang sobek", _on_read_notice)
	add_hotspot("Dengarkan suara aneh di balik gerbang", _on_listen_sound)
	add_hotspot("Lihat ke belakang, ke jalan yang kamu lewati", _on_look_back)

func _on_flashlight() -> void:
	GameManager.add_item("Senter", "Senter")
	play_jumpscare("SESUATU BERGERAK DI PINGGIR CAHAYA")
	set_narrative("Senter menyala berkedip. Cahayanya gemetar, seolah dia juga tidak ingin ada di sini. Pada bagian belakangnya terukir nama: 'FINAL SCENE SECURITY — 1985'. Tapi kamu ingat baru baca papan tadi bilang 1987. Salah satu dari angka itu bohong.")

func _on_read_notice() -> void:
	set_narrative("\"DICARI: FIGURAN UNTUK SYUTING MALAM. TAK ADA YANG PERNAH MENINGGALKAN LOT INI.\" Tintanya terlihat masih baru — terlalu baru untuk tahun 1987. Tanggal di bawah bercetak hari ini. Nama yang harus datang untuk casting: nama yang sama dengan namamu. Kamu tidak ingat pernah daftar casting apapun.")

func _on_listen_sound() -> void:
	play_jumpscare("SUARA ITU MAKIN DEKAT")
	set_narrative("Kamu mendengarkan. Dari dalam lot, ada suara... seperti deretan kursi yang digeser. Atau mungkin... kaki yang melangkah. Suara itu berhenti tepat ketika kamu memperhatikan — seolah dia tahu kamu sedang mendengarkan.")

func _on_look_back() -> void:
	set_narrative("Kamu menoleh ke jalan yang tadi kamu lewati untuk sampai ke sini. Tidak ada jalan. Hanya kabut putih pekat, sejauh mata memandang, seperti tidak pernah ada apapun di belakangmu sebelum kamu berdiri di gerbang ini.")

func _on_enter_soundstage() -> void:
	if not GameManager.has_item("Senter"):
		set_narrative("Gelap gulita di balik gerbang. Sebaiknya cari sumber cahaya dulu. Tidak ada yang akan menolong jika kamu tersesat.")
		return
	GameManager.goto_scene("res://scenes/RoomSoundstage.tscn")