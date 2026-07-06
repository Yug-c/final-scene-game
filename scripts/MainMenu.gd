extends Control

func _ready() -> void:
	set_anchors_preset(Control.PRESET_FULL_RECT)

	var bg := ColorRect.new()
	bg.color = Color(0.02, 0.02, 0.03)
	bg.set_anchors_preset(Control.PRESET_FULL_RECT)
	add_child(bg)

	var vsize := get_viewport_rect().size

	_setup_creepy_atmosphere(vsize)

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

func _setup_creepy_atmosphere(vsize: Vector2) -> void:
	var silhouette := Polygon2D.new()
	silhouette.color = Color(0.0, 0.0, 0.0, 0.0)
	var head_r := 22.0
	var body_w := 46.0
	var body_h := 130.0
	silhouette.polygon = PackedVector2Array([
		Vector2(-body_w/2, 0), Vector2(body_w/2, 0),
		Vector2(body_w/2 - 6, body_h * 0.55), Vector2(body_w/2 + 4, body_h),
		Vector2(-body_w/2 - 4, body_h), Vector2(-body_w/2 + 6, body_h * 0.55)
	])
	add_child(silhouette)

	var head := Polygon2D.new()
	head.color = Color(0.0, 0.0, 0.0, 0.0)
	var pts := PackedVector2Array()
	for i in range(16):
		var angle = i * TAU / 16
		pts.append(Vector2(cos(angle), sin(angle)) * head_r)
	head.polygon = pts
	head.position = Vector2(0, -head_r * 0.9)
	silhouette.add_child(head)

	silhouette.position = Vector2(vsize.x * 0.82, vsize.y * 0.55)
	_loop_silhouette_flicker(silhouette, head)

	var flicker := ColorRect.new()
	flicker.color = Color(0, 0, 0, 0.0)
	flicker.set_anchors_preset(Control.PRESET_FULL_RECT)
	flicker.mouse_filter = Control.MOUSE_FILTER_IGNORE
	add_child(flicker)
	_loop_light_flicker(flicker)

	for i in range(14):
		var dot := ColorRect.new()
		var size := randf_range(2.0, 4.0)
		dot.size = Vector2(size, size)
		dot.color = Color(0.6, 0.55, 0.5, randf_range(0.1, 0.3))
		dot.mouse_filter = Control.MOUSE_FILTER_IGNORE
		dot.position = Vector2(randf_range(0, vsize.x), randf_range(0, vsize.y))
		add_child(dot)
		_loop_dust_drift(dot, vsize)

func _loop_silhouette_flicker(silhouette: Polygon2D, head: Polygon2D) -> void:
	while is_instance_valid(silhouette):
		await get_tree().create_timer(randf_range(6.0, 12.0)).timeout
		if not is_instance_valid(silhouette):
			return
		var tw := create_tween()
		var target_alpha := randf_range(0.08, 0.18)
		tw.tween_property(silhouette, "color:a", target_alpha, 0.4)
		tw.parallel().tween_property(head, "color:a", target_alpha, 0.4)
		tw.tween_interval(randf_range(0.5, 1.5))
		tw.tween_property(silhouette, "color:a", 0.0, 0.6)
		tw.parallel().tween_property(head, "color:a", 0.0, 0.6)
		await tw.finished

func _loop_light_flicker(flicker: ColorRect) -> void:
	while is_instance_valid(flicker):
		await get_tree().create_timer(randf_range(4.0, 9.0)).timeout
		if not is_instance_valid(flicker):
			return
		var tw := create_tween()
		for i in range(randi_range(2, 4)):
			tw.tween_property(flicker, "color:a", randf_range(0.15, 0.3), 0.05)
			tw.tween_property(flicker, "color:a", 0.0, 0.08)
		await tw.finished

func _loop_dust_drift(dot: ColorRect, vsize: Vector2) -> void:
	while is_instance_valid(dot):
		var target := Vector2(randf_range(0, vsize.x), randf_range(0, vsize.y))
		var tw := create_tween()
		tw.tween_property(dot, "position", target, randf_range(8.0, 16.0))
		await tw.finished

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
