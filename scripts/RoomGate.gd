extends BaseRoom

func _ready() -> void:
	bg_color = Color(0.04, 0.05, 0.08)
	room_title = "STUDIO GATE — FINAL SCENE LOT"
	narrative = "Gerbang berpagar rantai tergantung terbuka. Papan pudar bertuliskan 'FINAL SCENE — DITUTUP SEJAK 1987'. Di balik kabut, lampu soundstage menyala sendiri. Seolah-olah menunggu sesuatu... atau seseorang."
	super._ready()
	GameManager.save_game()

func on_room_ready() -> void:
	add_hotspot("Ambil senter yang tergeletak", _on_flashlight)
	add_hotspot("Berjalan menuju soundstage", _on_enter_soundstage)
	add_hotspot("Baca pengumuman casting yang sobek", _on_read_notice)
	add_hotspot("Dengarkan suara aneh di balik gerbang", _on_listen_sound)

func _on_flashlight() -> void:
	GameManager.add_item("Senter", "Senter")
	set_narrative("Senter menyala berkedip. Cahayanya gemetar, seolah dia juga tidak ingin ada di sini. Pada bagian belakangnya terukir nama: 'FINAL SCENE SECURITY — 1985'.")

func _on_read_notice() -> void:
	set_narrative("\"DICARI: FIGURAN UNTUK SYUTING MALAM. TAK ADA YANG PERNAH MENINGGALKAN LOT INI.\" Tintanya terlihat masih baru — terlalu baru untuk tahun 1987. Tanggal di bawah bercetak hari ini.")

func _on_listen_sound() -> void:
	set_narrative("Kamu mendengarkan. Dari dalam lot, ada suara... seperti deretan kursi yang digeser. Atau mungkin... kaki yang melangkah. Suara itu berhenti ketika kamu memperhatikan.")

func _on_enter_soundstage() -> void:
	if not GameManager.has_item("Senter"):
		set_narrative("Gelap gulita di balik gerbang. Sebaiknya cari sumber cahaya dulu. Tidak ada yang akan menolong jika kamu tersesat.")
		return
	GameManager.goto_scene("res://scenes/RoomSoundstage.tscn")