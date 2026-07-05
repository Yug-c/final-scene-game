extends BaseRoom

func _ready() -> void:
	bg_color = Color(0.07, 0.02, 0.02)
	room_title = "SOUNDSTAGE 13"
	narrative = "Kamera berkarat menghadap set kosong. Spotlight-spotlight tua berdiri seperti sentri. Sebuah gulungan film tergeletak di kursi sutradara. Sekilas kamu yakin ada bayangan melintas di balik tirai — tapi saat kamu memandang langsung, tidak ada apa-apa."
	super._ready()

func on_room_ready() -> void:
	GameManager.save_game()
	add_hotspot("Ambil gulungan film", _on_take_reel)
	add_hotspot("Periksa balik tirai", _on_check_curtain)
	add_hotspot("Inspect kamera tua itu", _on_inspect_camera)
	add_hotspot("Menuju trailer wardrobe", _on_go_wardrobe)
	add_hotspot("Kembali ke gerbang", _on_go_gate)

func _on_take_reel() -> void:
	GameManager.add_item("Gulungan Film", "Gulungan Film")
	set_narrative("Label di gulungan itu: 'FINAL TAKE — JANGAN DIPUTAR'. Terasa lebih dingin dari seharusnya. Bagian belakangnya ada kalimat lain, tulisan tangan: 'Jika kamu menonton ini, aku sudah tidak di sini lagi.'")

func _on_check_curtain() -> void:
	play_jumpscare("SESUATU MENGAWASIMU")
	set_narrative("Kamu menekan tirai. Di belakangnya hanya kosong — studio belakang yang gelap. Tapi sebelum kamu tarik tangan, sesuatu memegang pergelangan tanganmu. Dingin. Cukup kuat. Kemudian lepas. Tirai kembali diam.")

func _on_inspect_camera() -> void:
	set_narrative("Kamera ini lensa-nya masih jernih. Aneh, mengingat berapa lama lot ini ditutup. Kamu lihat melalui viewfinder. Di layar itu, kamu lihat ruangan yang sama — tapi dengan boneka-boneka duduk di kursi penonton, semua menghadap kamera. Ketika kamu turunkan kamera, kursi-kursi itu kosong.")

func _on_go_wardrobe() -> void:
	GameManager.goto_scene("res://scenes/RoomWardrobe.tscn")

func _on_go_gate() -> void:
	GameManager.goto_scene("res://scenes/RoomGate.tscn")