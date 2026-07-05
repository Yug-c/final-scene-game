extends BaseRoom

func _ready() -> void:
	bg_color = Color(0.03, 0.03, 0.03)
	room_title = "RUANG PEMUTARAN"
	narrative = "Deretan kursi kosong menghadap layar putih. Sebuah proyektor berdengung, menunggu untuk diisi."
	super._ready()

func on_room_ready() -> void:
	if GameManager.has_item("Gulungan Film"):
		add_hotspot("Pasang gulungan film ke proyektor", _on_play_reel)
	else:
		add_hotspot("Cari jalan keluar lain", _on_search_no_reel)
	add_hotspot("Kembali ke wardrobe", _on_go_back)

func _on_play_reel() -> void:
	clear_hotspots()
	set_narrative("Proyektor menyala berderak. Di layar: ruangan ini juga, persis. Momen ini juga, persis. Kamu, persis, sedang berbalik...")
	await get_tree().create_timer(1.4).timeout
	play_jumpscare("KAMU SELALU JADI FINAL TAKE")
	await get_tree().create_timer(1.6).timeout
	GameManager.goto_scene("res://scenes/EndingScene.tscn")

func _on_search_no_reel() -> void:
	set_narrative("Pasti ada gulungan film di suatu tempat di lot ini. Proyektor kosong tak bisa memutar apa-apa.")

func _on_go_back() -> void:
	GameManager.goto_scene("res://scenes/RoomWardrobe.tscn")
