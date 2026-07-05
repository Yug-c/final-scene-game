extends Control

var master_volume: float = 0.8
var brightness: float = 1.0
var difficulty: String = "Normal"
var show_subtitles: bool = true

func _ready() -> void:
	set_anchors_preset(Control.PRESET_FULL_RECT)

	var bg := ColorRect.new()
	bg.color = Color(0.02, 0.02, 0.03)
	bg.set_anchors_preset(Control.PRESET_FULL_RECT)
	add_child(bg)

	var vsize := get_viewport_rect().size
	var scroll := ScrollContainer.new()
	scroll.set_anchors_preset(Control.PRESET_FULL_RECT)
	scroll.custom_minimum_size = vsize
	add_child(scroll)

	var vbox := VBoxContainer.new()
	vbox.custom_minimum_size = Vector2(vsize.x, vsize.y + 200)
	vbox.add_theme_constant_override("separation", 20)
	scroll.add_child(vbox)

	var title := Label.new()
	title.text = "⚙ SETTINGS"
	title.add_theme_font_size_override("font_size", 44)
	title.add_theme_color_override("font_color", Color(0.85, 0.1, 0.1))
	title.custom_minimum_size = Vector2(vsize.x, 60)
	title.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	vbox.add_child(title)

	var audio_title := Label.new()
	audio_title.text = "🔊 AUDIO"
	audio_title.add_theme_font_size_override("font_size", 20)
	audio_title.add_theme_color_override("font_color", Color(0.9, 0.8, 0.6))
	vbox.add_child(audio_title)

	var vol_label := Label.new()
	vol_label.text = "Master Volume"
	vol_label.add_theme_font_size_override("font_size", 14)
	vol_label.add_theme_color_override("font_color", Color(0.7, 0.7, 0.65))
	vbox.add_child(vol_label)

	var vol_hbox := HBoxContainer.new()
	vol_hbox.custom_minimum_size = Vector2(vsize.x - 60, 50)
	vbox.add_child(vol_hbox)

	var slider := HSlider.new()
	slider.min_value = 0.0
	slider.max_value = 1.0
	slider.value = master_volume
	slider.custom_minimum_size = Vector2(vsize.x - 180, 40)
	slider.value_changed.connect(_on_volume_changed)
	vol_hbox.add_child(slider)

	var vol_percent := Label.new()
	vol_percent.text = "80%"
	vol_percent.name = "VolumePercent"
	vol_percent.add_theme_font_size_override("font_size", 14)
	vol_percent.add_theme_color_override("font_color", Color(0.85, 0.85, 0.7))
	vol_percent.custom_minimum_size = Vector2(80, 40)
	vol_hbox.add_child(vol_percent)

	var subtitle_label := Label.new()
	subtitle_label.text = "Tampilkan Subtitel"
	subtitle_label.add_theme_font_size_override("font_size", 14)
	subtitle_label.add_theme_color_override("font_color", Color(0.7, 0.7, 0.65))
	vbox.add_child(subtitle_label)

	var subtitle_hbox := HBoxContainer.new()
	subtitle_hbox.custom_minimum_size = Vector2(vsize.x - 60, 50)
	vbox.add_child(subtitle_hbox)

	var subtitle_btn := Button.new()
	subtitle_btn.text = "ON" if show_subtitles else "OFF"
	subtitle_btn.custom_minimum_size = Vector2(100, 40)
	subtitle_btn.toggled.connect(_on_subtitle_toggle)
	subtitle_btn.toggle_mode = true
	subtitle_btn.button_pressed = show_subtitles
	_style_small_button(subtitle_btn)
	subtitle_hbox.add_child(subtitle_btn)

	var gfx_title := Label.new()
	gfx_title.text = "🎨 GRAPHICS"
	gfx_title.add_theme_font_size_override("font_size", 20)
	gfx_title.add_theme_color_override("font_color", Color(0.9, 0.8, 0.6))
	vbox.add_child(gfx_title)

	var bright_label := Label.new()
	bright_label.text = "Brightness"
	bright_label.add_theme_font_size_override("font_size", 14)
	bright_label.add_theme_color_override("font_color", Color(0.7, 0.7, 0.65))
	vbox.add_child(bright_label)

	var bright_hbox := HBoxContainer.new()
	bright_hbox.custom_minimum_size = Vector2(vsize.x - 60, 50)
	vbox.add_child(bright_hbox)

	var bright_slider := HSlider.new()
	bright_slider.min_value = 0.3
	bright_slider.max_value = 1.5
	bright_slider.value = brightness
	bright_slider.custom_minimum_size = Vector2(vsize.x - 180, 40)
	bright_slider.value_changed.connect(_on_brightness_changed)
	bright_hbox.add_child(bright_slider)

	var bright_percent := Label.new()
	bright_percent.text = "100%"
	bright_percent.name = "BrightnessPercent"
	bright_percent.add_theme_font_size_override("font_size", 14)
	bright_percent.add_theme_color_override("font_color", Color(0.85, 0.85, 0.7))
	bright_percent.custom_minimum_size = Vector2(80, 40)
	bright_hbox.add_child(bright_percent)

	var gp_title := Label.new()
	gp_title.text = "🎮 GAMEPLAY"
	gp_title.add_theme_font_size_override("font_size", 20)
	gp_title.add_theme_color_override("font_color", Color(0.9, 0.8, 0.6))
	vbox.add_child(gp_title)

	var diff_label := Label.new()
	diff_label.text = "Difficulty"
	diff_label.add_theme_font_size_override("font_size", 14)
	diff_label.add_theme_color_override("font_color", Color(0.7, 0.7, 0.65))
	vbox.add_child(diff_label)

	var diff_hbox := HBoxContainer.new()
	diff_hbox.custom_minimum_size = Vector2(vsize.x - 60, 50)
	diff_hbox.add_theme_constant_override("separation", 10)
	vbox.add_child(diff_hbox)

	for diff in ["Easy", "Normal", "Hard"]:
		var diff_btn := Button.new()
		diff_btn.text = diff
		diff_btn.custom_minimum_size = Vector2(80, 40)
		diff_btn.pressed.connect(func(): _on_difficulty_changed(diff))
		if diff == "Normal":
			_style_small_button_active(diff_btn)
		else:
			_style_small_button(diff_btn)
		diff_hbox.add_child(diff_btn)

	var data_title := Label.new()
	data_title.text = "💾 DATA"
	data_title.add_theme_font_size_override("font_size", 20)
	data_title.add_theme_color_override("font_color", Color(0.9, 0.8, 0.6))
	vbox.add_child(data_title)

	var reset_btn := Button.new()
	reset_btn.text = "🗑 RESET ALL DATA"
	reset_btn.custom_minimum_size = Vector2(300, 60)
	reset_btn.pressed.connect(_on_reset_data)
	_style_button(reset_btn)
	vbox.add_child(reset_btn)

	var warning := Label.new()
	warning.text = "(Akan menghapus semua progress & save game)"
	warning.add_theme_font_size_override("font_size", 11)
	warning.add_theme_color_override("font_color", Color(0.7, 0.3, 0.1))
	warning.custom_minimum_size = Vector2(vsize.x - 60, 30)
	warning.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	warning.autowrap_mode = TextServer.AUTOWRAP_WORD
	vbox.add_child(warning)

	var back_btn := Button.new()
	back_btn.text = "← BACK TO MENU"
	back_btn.custom_minimum_size = Vector2(300, 60)
	back_btn.pressed.connect(_on_back)
	_style_button(back_btn)
	vbox.add_child(back_btn)

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

func _style_small_button(btn: Button) -> void:
	var sb := StyleBoxFlat.new()
	sb.bg_color = Color(0.08, 0.08, 0.1, 0.8)
	sb.border_color = Color(0.4, 0.4, 0.4)
	sb.set_border_width_all(1)
	sb.set_corner_radius_all(6)
	btn.add_theme_stylebox_override("normal", sb)
	btn.add_theme_color_override("font_color", Color(0.7, 0.7, 0.65))

func _style_small_button_active(btn: Button) -> void:
	var sb := StyleBoxFlat.new()
	sb.bg_color = Color(0.15, 0.05, 0.05, 0.9)
	sb.border_color = Color(0.7, 0.15, 0.15)
	sb.set_border_width_all(2)
	sb.set_corner_radius_all(6)
	btn.add_theme_stylebox_override("normal", sb)
	btn.add_theme_color_override("font_color", Color(0.95, 0.8, 0.6))

func _on_volume_changed(value: float) -> void:
	master_volume = value

func _on_brightness_changed(value: float) -> void:
	brightness = value

func _on_subtitle_toggle(pressed: bool) -> void:
	show_subtitles = pressed

func _on_difficulty_changed(diff: String) -> void:
	difficulty = diff

func _on_reset_data() -> void:
	GameManager.reset_game()
	GameManager.goto_scene("res://scenes/MainMenu.tscn")

func _on_back() -> void:
	GameManager.goto_scene("res://scenes/MainMenu.tscn")