extends Control

func _ready() -> void:
	set_anchors_preset(Control.PRESET_FULL_RECT)
	
	var bg := ColorRect.new()
	bg.color = Color(0.05, 0.02, 0.02)
	bg.set_anchors_preset(Control.PRESET_FULL_RECT)
	add_child(bg)
	
	var container := Control.new()
	container.set_anchors_preset(Control.PRESET_CENTER)
	container.custom_minimum_size = Vector2(300, 200)
	add_child(container)
	
	var logo := Label.new()
	logo.text = "LeoDev"
	logo.add_theme_font_size_override("font_size", 56)
	logo.add_theme_color_override("font_color", Color(0.9, 0.85, 0.7))
	logo.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	logo.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	logo.custom_minimum_size = Vector2(300, 120)
	logo.modulate.a = 0.0
	logo.scale = Vector2(0.6, 0.6)
	container.add_child(logo)
	
	var subtitle := Label.new()
	subtitle.text = "presents"
	subtitle.add_theme_font_size_override("font_size", 20)
	subtitle.add_theme_color_override("font_color", Color(0.7, 0.2, 0.1))
	subtitle.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	subtitle.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	subtitle.custom_minimum_size = Vector2(300, 60)
	subtitle.modulate.a = 0.0
	subtitle.position = Vector2(0, 100)
	container.add_child(subtitle)
	
	_play_animation(logo, subtitle)

func _play_animation(logo: Label, subtitle: Label) -> void:
	var tw := create_tween()
	tw.set_parallel(true)
	tw.tween_property(logo, "modulate:a", 1.0, 0.6)
	tw.tween_property(logo, "scale", Vector2(1.0, 1.0), 0.6)
	
	tw.tween_callback(func(): 
		var tw2 := create_tween()
		tw2.tween_property(subtitle, "modulate:a", 1.0, 0.4)
	)
	
	tw.tween_interval(1.3)
	
	tw.set_parallel(true)
	tw.tween_property(logo, "modulate:a", 0.0, 0.7)
	tw.tween_property(logo, "rotation", TAU / 2, 0.7)
	tw.tween_property(subtitle, "modulate:a", 0.0, 0.7)
	
	tw.tween_callback(func(): GameManager.goto_scene("res://scenes/MainMenu.tscn"))