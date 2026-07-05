class_name BaseRoom
extends Control

var bg_color: Color = Color(0.05, 0.05, 0.08)
var room_title: String = "???"
var narrative: String = ""

var title_label: Label
var narrative_label: RichTextLabel
var hotspot_box: VBoxContainer
var inventory_bar: HBoxContainer
var jumpscare_layer: CanvasLayer
var flash_rect: ColorRect
var scare_label: Label

func _ready() -> void:
	set_anchors_preset(Control.PRESET_FULL_RECT)
	_build_background()
	_build_title_and_narrative()
	_build_hotspot_box()
	_build_inventory_bar()
	_build_jumpscare_layer()
	GameManager.inventory_changed.connect(_refresh_inventory_bar)
	on_room_ready()

func on_room_ready() -> void:
	pass

func _build_background() -> void:
	var bg := ColorRect.new()
	bg.color = bg_color
	bg.set_anchors_preset(Control.PRESET_FULL_RECT)
	bg.mouse_filter = Control.MOUSE_FILTER_IGNORE
	add_child(bg)

	var vignette := ColorRect.new()
	vignette.color = Color(0, 0, 0, 0.35)
	vignette.set_anchors_preset(Control.PRESET_FULL_RECT)
	vignette.mouse_filter = Control.MOUSE_FILTER_IGNORE
	add_child(vignette)

func _build_title_and_narrative() -> void:
	title_label = Label.new()
	title_label.text = room_title
	title_label.add_theme_font_size_override("font_size", 30)
	title_label.add_theme_color_override("font_color", Color(0.85, 0.15, 0.15))
	title_label.position = Vector2(30, 70)
	title_label.custom_minimum_size = Vector2(get_viewport_rect().size.x - 60, 40)
	title_label.autowrap_mode = TextServer.AUTOWRAP_WORD
	add_child(title_label)

	narrative_label = RichTextLabel.new()
	narrative_label.bbcode_enabled = true
	narrative_label.text = "[i]%s[/i]" % narrative
	narrative_label.add_theme_color_override("default_color", Color(0.85, 0.85, 0.8))
	narrative_label.position = Vector2(30, 130)
	narrative_label.custom_minimum_size = Vector2(get_viewport_rect().size.x - 60, 260)
	narrative_label.scroll_active = false
	narrative_label.modulate.a = 1.0
	add_child(narrative_label)

func set_narrative(text: String) -> void:
	narrative = text
	narrative_label.text = "[i]%s[/i]" % text

func _build_hotspot_box() -> void:
	hotspot_box = VBoxContainer.new()
	hotspot_box.position = Vector2(30, get_viewport_rect().size.y - 320)
	hotspot_box.custom_minimum_size = Vector2(get_viewport_rect().size.x - 60, 300)
	hotspot_box.add_theme_constant_override("separation", 12)
	add_child(hotspot_box)

func add_hotspot(text: String, callback: Callable) -> void:
	var btn := Button.new()
	btn.text = text
	btn.custom_minimum_size = Vector2(0, 60)
	var sb := StyleBoxFlat.new()
	sb.bg_color = Color(0.1, 0.1, 0.12, 0.92)
	sb.border_color = Color(0.6, 0.1, 0.1)
	sb.set_border_width_all(2)
	sb.set_corner_radius_all(10)
	sb.content_margin_left = 16
	sb.content_margin_right = 16
	btn.add_theme_stylebox_override("normal", sb)
	btn.add_theme_color_override("font_color", Color(0.9, 0.85, 0.7))
	btn.pressed.connect(callback)
	hotspot_box.add_child(btn)

func clear_hotspots() -> void:
	for c in hotspot_box.get_children():
		c.queue_free()

func _build_inventory_bar() -> void:
	inventory_bar = HBoxContainer.new()
	inventory_bar.position = Vector2(30, 24)
	inventory_bar.add_theme_constant_override("separation", 14)
	add_child(inventory_bar)
	_refresh_inventory_bar()

func _refresh_inventory_bar() -> void:
	for c in inventory_bar.get_children():
		c.queue_free()
	for item_id in GameManager.inventory:
		var chip := Label.new()
		chip.text = "\u25a3 %s" % item_id
		chip.add_theme_font_size_override("font_size", 14)
		chip.add_theme_color_override("font_color", Color(0.8, 0.7, 0.2))
		inventory_bar.add_child(chip)

func _build_jumpscare_layer() -> void:
	jumpscare_layer = CanvasLayer.new()
	jumpscare_layer.layer = 10
	jumpscare_layer.visible = false
	add_child(jumpscare_layer)

	flash_rect = ColorRect.new()
	flash_rect.color = Color(0.7, 0, 0, 1)
	flash_rect.set_anchors_preset(Control.PRESET_FULL_RECT)
	flash_rect.modulate.a = 0.0
	jumpscare_layer.add_child(flash_rect)

	scare_label = Label.new()
	scare_label.text = "!!"
	scare_label.add_theme_font_size_override("font_size", 44)
	scare_label.add_theme_color_override("font_color", Color(1, 1, 1))
	scare_label.set_anchors_preset(Control.PRESET_CENTER)
	scare_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	scare_label.modulate.a = 0.0
	jumpscare_layer.add_child(scare_label)

func play_jumpscare(text: String = "IT'S BEHIND YOU") -> void:
	scare_label.text = text
	jumpscare_layer.visible = true
	flash_rect.modulate.a = 0.0
	scare_label.modulate.a = 0.0

	var tw := create_tween()
	tw.tween_property(flash_rect, "modulate:a", 0.85, 0.05)
	tw.parallel().tween_property(scare_label, "modulate:a", 1.0, 0.05)
	tw.tween_interval(0.35)
	tw.tween_property(flash_rect, "modulate:a", 0.0, 0.6)
	tw.parallel().tween_property(scare_label, "modulate:a", 0.0, 0.6)
	tw.tween_callback(func(): jumpscare_layer.visible = false)