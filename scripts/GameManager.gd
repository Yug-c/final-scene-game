extends Node

signal inventory_changed
signal item_added(item_name: String)

var inventory: Array[String] = []
var flags: Dictionary = {}
var current_scene: String = ""
var has_save: bool = false

const SAVE_PATH := "user://final_scene_save.json"

func _ready() -> void:
	has_save = ResourceLoader.exists(SAVE_PATH)

func add_item(item_id: String, display_name: String) -> void:
	if item_id in inventory:
		return
	inventory.append(item_id)
	item_added.emit(display_name)
	inventory_changed.emit()

func has_item(item_id: String) -> bool:
	return item_id in inventory

func set_flag(flag_name: String, value: bool = true) -> void:
	flags[flag_name] = value

func get_flag(flag_name: String) -> bool:
	return flags.get(flag_name, false)

func goto_scene(path: String) -> void:
	current_scene = path
	get_tree().change_scene_to_file(path)

func save_game() -> void:
	var save_data := {
		"inventory": inventory,
		"flags": flags,
		"current_scene": current_scene
	}
	var json_str := JSON.stringify(save_data)
	var file := FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	if file:
		file.store_string(json_str)
		has_save = true

func load_game() -> bool:
	if not ResourceLoader.exists(SAVE_PATH):
		return false
	
	var file := FileAccess.open(SAVE_PATH, FileAccess.READ)
	if not file:
		return false
	
	var json_str := file.get_as_text()
	var json := JSON.new()
	if json.parse(json_str) != OK:
		return false
	
	var save_data = json.data
	inventory = save_data.get("inventory", [])
	flags = save_data.get("flags", {})
	current_scene = save_data.get("current_scene", "")
	inventory_changed.emit()
	return true

func reset_game() -> void:
	inventory.clear()
	flags.clear()
	current_scene = ""
	if ResourceLoader.exists(SAVE_PATH):
		DirAccess.remove_absolute(SAVE_PATH)
	has_save = false