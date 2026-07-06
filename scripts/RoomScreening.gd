extends BaseRoom

var has_played_reel: bool = false

func _ready() -> void:
	bg_color = Color(0.03, 0.03, 0.03)
	room_title = "RUANG PEMUTARAN"
	narrative = "Deretan kursi kosong menghadap layar putih. Sebuah proyektor berdengung, menunggu untuk diisi. Di dinding samping, ada poster-poster film dari era 1980-an. Tapi saat kamu lihat lebih dekat, semua aktornya punya wajah yang sama. Wajahmu. Judul film di posternya selalu sama: 'FINAL SCENE'. Tahun rilisnya berbeda-beda — 1961, 1987, 2003, dan tahun ini."
	super._ready()

func on_room_ready() -> void:
	GameManager.save_game()
	if GameManager.has_item("Gulungan Film"):
		add_hotspot("Pasang gulungan film ke proyektor", _on_play_reel)
	else:
		add_hotspot("Cari jalan keluar lain", _on_search_no_reel)
	add_hotspot("Duduk di salah satu kursi", _on_sit_chair)
	add_hotspot("Periksa poster-poster di dinding", _on_check_posters)
	add_hotspot("Kembali ke wardrobe", _on_go_back)

func _on_play_reel() -> void:
	if has_played_reel:
		return
	has_played_reel = true
	clear_hotspots()
	play_jumpscare("KURSI DI BELAKANGMU BERDERAK SENDIRI")
	set_narrative("Kamu memasang gulungan ke proyektor. Mesin berderak, dan cahaya putih menyala. Tapi film itu... film itu adalah awal kejadian. Kamu berdiri di depan layar. Proyektor menunjukkan ruangan ini juga — persis sama. Lalu kamera fokus ke kursi kosong di depan. Kursi itu perlahan tertarik ke belakang, membuat suara metal yang mengecil. Layar menjadi hitam.")
	await get_tree().create_timer(2.2).timeout
	play_jumpscare("KAMU MELIHAT DIRIMU SENDIRI DI LAYAR, TERSENYUM")
	await get_tree().create_timer(2.0).timeout
	set_narrative("Layar menyala lagi. Sosok di layar itu — kamu — menoleh perlahan ke arah kamera, seolah menoleh langsung ke arahmu yang duduk di sini. Dia tersenyum. Kamu tidak ingat pernah tersenyum seperti itu seumur hidupmu.")
	await get_tree().create_timer(2.5).timeout
	play_jumpscare("KAMU SUDAH DALAM FRAME")
	await get_tree().create_timer(1.5).timeout
	GameManager.goto_scene("res://scenes/EndingScene.tscn")

func _on_search_no_reel() -> void:
	set_narrative("Pasti ada gulungan film di suatu tempat di lot ini. Proyektor kosong tidak bisa memutar apa-apa. Tapi... suara proyektor ini terus berdengung, seolah menunggu sesuatu yang tidak akan pernah datang.")

func _on_sit_chair() -> void:
	play_jumpscare("KURSI DI SAMPINGMU BERDECIT SENDIRI")
	set_narrative("Kamu duduk di salah satu kursi. Empuk, tapi dingin. Sangat dingin. Kamu perhatikan bahwa kursi-kursi di sekitarmu memiliki cekungan di kain — bekas orang yang duduk. Banyak orang. Dan bekas-bekas itu tidak bisa lebih dari beberapa hari lama. Kursi di sebelahmu berdecit, seakan seseorang baru saja berdiri dari sana.")

func _on_check_posters() -> void:
	set_narrative("Empat poster, empat tahun berbeda, satu wajah yang sama — wajahmu, di setiap era, memakai kostum yang berbeda tapi mimik yang identik: mulut sedikit terbuka, seperti berteriak yang tidak terdengar. Kamu menghitung: 1961, 1987, 2003, tahun ini. Selisihnya tidak masuk akal — tidak ada pola matematis yang bisa menjelaskan siklus ini. Seolah film ini dibuat ulang setiap kali seseorang sepertimu berjalan masuk ke gerbang itu.")

func _on_go_back() -> void:
	GameManager.goto_scene("res://scenes/RoomWardrobe.tscn")