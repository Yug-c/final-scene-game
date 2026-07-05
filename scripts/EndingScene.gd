extends BaseRoom

var typewriter_label: Label

func _ready() -> void:
	bg_color = Color(0.0, 0.0, 0.0)
	room_title = "FADE TO BLACK"
	narrative = ""
	super._ready()

func on_room_ready() -> void:
	narrative_label.modulate.a = 0.0
	narrative_label.visible = true
	_play_typewriter_animation()

func _play_typewriter_animation() -> void:
	typewriter_label = Label.new()
	typewriter_label.text = ""
	typewriter_label.add_theme_font_size_override("font_size", 48)
	typewriter_label.add_theme_color_override("font_color", Color(0.9, 0.15, 0.15))
	typewriter_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	typewriter_label.set_anchors_preset(Control.PRESET_CENTER)
	typewriter_label.custom_minimum_size = Vector2(600, 100)
	typewriter_label.modulate.a = 0.0
	add_child(typewriter_label)
	
	var full_text = "FINAL SCENE"
	var tw := create_tween()
	tw.tween_property(typewriter_label, "modulate:a", 1.0, 0.3)
	
	for i in range(full_text.length()):
		tw.tween_callback(func():
			typewriter_label.text = full_text.substr(0, i + 1)
		)
		tw.tween_interval(0.15)
	
	tw.tween_interval(1.0)
	
	tw.tween_property(typewriter_label, "modulate:a", 0.0, 0.8)
	tw.tween_callback(func():
		narrative_label.text = "[i]Gulungan film berakhir. Lampu-lampu Final Scene padam satu per satu, soundstage demi soundstage. Di suatu tempat, pengumuman casting baru sedang dicetak — dengan namamu di dalamnya.\n\n— TAMAT —[/i]"
	)
	
	tw.tween_property(narrative_label, "modulate:a", 1.0, 0.5)
	tw.tween_interval(1.0)
	
	tw.tween_callback(func():
		add_hotspot("Main lagi dari awal", _on_restart)
		add_hotspot("Kembali ke menu utama", _on_back_menu)
	)

func _on_restart() -> void:
	GameManager.reset_game()
	GameManager.goto_scene("res://scenes/RoomGate.tscn")

func _on_back_menu() -> void:
	GameManager.reset_game()
	GameManager.goto_scene("res://scenes/MainMenu.tscn")