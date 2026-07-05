extends Control

func _ready() -> void:
	set_anchors_preset(Control.PRESET_FULL_RECT)

	var bg := ColorRect.new()
	bg.color = Color(0.02, 0.02, 0.03)
	bg.set_anchors_preset(Control.PRESET_FULL_RECT)
	add_child(bg)

	var vsize := get_viewport_rect().size

	var dev := Label.new()
	dev.text = "A LeoDev Production"
	dev.add_theme_font_size_override("font_size", 14)
	dev.add_theme_color_override("font_color", Color(0.6, 0.5, 0.4))
	dev.custom_minimum_size = Vector2(vsize.x, 30)
	dev.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	dev.position = Vector2(0, 50)
	add_child(dev)

	var title := Label.new()
	title.text = "FINAL SCENE"
	title.add_theme_font_size_override("font_size", 72)
	title.add_theme_color_override("font_color", Color(0.9, 0.15, 0.15))
	title.custom_minimum_size = Vector2(vsize.x, 100)
	title.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	title.position = Vector2(0, 100)
	add_child(title)

	var subtitle := Label.new()
	subtitle.text = "A Hollywood Horror"
	subtitle.add_theme_font_size_override("font_size", 20)
	subtitle.add_theme_color_override("font_color", Color(0.7, 0.2, 0.1))
	subtitle.custom_minimum_size = Vector2(vsize.x, 40)
	subtitle.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	subtitle.position = Vector2(0, 200)
	add_child(subtitle)

	var btn_y := 300
	var btn_width := 280
	var btn_height := 60
	var btn_x := vsize.x / 2 - btn_width / 2
	var btn_gap := 80

	var new_btn := Button.new()
	new_btn.text = "NEW GAME"
	new_btn.custom_minimum_size = Vector2(btn_width, btn_height)
	new_btn.position = Vector2(btn_x, btn_y)
	new_btn.pressed.connect(_on_new_game)
	_style_button(new_btn)
	add_child(new_btn)

	var load_btn := Button.new()
	load_btn.text = "LOAD GAME"
	load_btn.custom_minimum_size = Vector2(btn_width, btn_height)
	load_btn.position = Vector2(btn_x, btn_y + btn_gap)
	load_btn.disabled = not GameManager.has_save
	load_btn.pressed.connect(_on_load_game)
	_style_button(load_btn)
	add_child(load_btn)

	var settings_btn := Button.new()
	settings_btn.text = "SETTINGS"
	settings_btn.custom_minimum_size = Vector2(btn_width, btn_height)
	settings_btn.position = Vector2(btn_x, btn_y + btn_gap * 2)
	settings_btn.pressed.connect(_on_settings)
	_style_button(settings_btn)
	add_child(settings_btn)

	var exit_btn := Button.new()
	exit_btn.text = "EXIT"
	exit_btn.custom_minimum_size = Vector2(btn_width, btn_height)
	exit_btn.position = Vector2(btn_x, btn_y + btn_gap * 3)
	exit_btn.pressed.connect(_on_exit)
	_style_button(exit_btn)
	add_child(exit_btn)

	var hint := Label.new()
	hint.text = "Point & click horror — jelajahi backlot studio yang ditinggalkan sejak 1987."
	hint.add_theme_font_size_override("font_size", 12)
	hint.add_theme_color_override("font_color", Color(0.5, 0.5, 0.5))
	hint.custom_minimum_size = Vector2(vsize.x - 60, 60)
	hint.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	hint.autowrap_mode = TextServer.AUTOWRAP_WORD
	hint.position = Vector2(30, vsize.y - 80)
	add_child(hint)

func _style_button(btn: Button) -> void:
	var sb := StyleBoxFlat.new()
	sb.bg_color = Color(0.1, 0.05, 0.05, 0.9)
	sb.border_color = Color(0.6, 0.1, 0.1)
	sb.set_border_width_all(2)
	sb.set_corner_radius_all(10)
	sb.content_margin_left = 16
	sb.content_margin_right = 16
	btn.add_theme_stylebox_override("normal", sb)
	btn.add_theme_color_override("font_color", Color(0.9, 0.85, 0.7))

func _on_new_game() -> void:
	GameManager.reset_game()
	GameManager.goto_scene("res://scenes/RoomGate.tscn")

func _on_load_game() -> void:
	if GameManager.load_game():
		GameManager.goto_scene(GameManager.current_scene)
	else:
		print("Load game gagal")

func _on_settings() -> void:
	GameManager.goto_scene("res://scenes/SettingsMenu.tscn")

func _on_exit() -> void:
	get_tree().quit()