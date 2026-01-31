## SaveSystem - Global save/load manager (Autoload singleton)
## Handles game state persistence
extends Node

## Emitted when game is saved
signal game_saved

## Emitted when game is loaded
signal game_loaded

## Emitted when save is deleted
signal save_deleted

## Save file path
const SAVE_PATH = "user://game_save.dat"

## Save file version (for compatibility)
const SAVE_VERSION = "1.0.0"

## Auto-saves game state
## Call this on quit, day transitions, critical moments
func auto_save() -> bool:
	var save_data = _collect_save_data()

	if save_data.is_empty():
		push_warning("SaveSystem: No data to save")
		return false

	return _write_save_file(save_data)

## Loads game from save file
## Returns true if successful
func load_game() -> bool:
	if not has_save():
		push_warning("SaveSystem: No save file found")
		return false

	var save_data = _read_save_file()

	if save_data.is_empty():
		push_error("SaveSystem: Failed to read save file")
		return false

	# Check version compatibility
	if "version" in save_data and save_data["version"] != SAVE_VERSION:
		push_warning("SaveSystem: Save file version mismatch (%s vs %s)" % [save_data["version"], SAVE_VERSION])
		# You could add migration logic here

	_restore_save_data(save_data)
	game_loaded.emit()
	return true

## Checks if save file exists
func has_save() -> bool:
	return FileAccess.file_exists(SAVE_PATH)

## Deletes save file
func delete_save() -> bool:
	if not has_save():
		return false

	var error = DirAccess.remove_absolute(SAVE_PATH)

	if error == OK:
		save_deleted.emit()
		print("SaveSystem: Save deleted")
		return true
	else:
		push_error("SaveSystem: Failed to delete save (error %d)" % error)
		return false

## Gets save file info
func get_save_info() -> Dictionary:
	if not has_save():
		return {}

	var save_data = _read_save_file()

	if save_data.is_empty():
		return {}

	return {
		"version": save_data.get("version", "unknown"),
		"timestamp": save_data.get("timestamp", "unknown"),
		"game_data": save_data.get("game_state", {})
	}

## Collects save data from game
## Override this in game-specific implementation or use GameState
func _collect_save_data() -> Dictionary:
	var data = {
		"version": SAVE_VERSION,
		"timestamp": Time.get_datetime_string_from_system(),
		"game_state": {}
	}

	# Collect from GameState if available
	if has_node("/root/GameState"):
		var game_state = get_node("/root/GameState")
		if game_state.has_method("serialize"):
			data["game_state"] = game_state.serialize()

	return data

## Restores save data to game
## Override this in game-specific implementation or use GameState
func _restore_save_data(data: Dictionary) -> void:
	# Restore to GameState if available
	if has_node("/root/GameState") and "game_state" in data:
		var game_state = get_node("/root/GameState")
		if game_state.has_method("deserialize"):
			game_state.deserialize(data["game_state"])

## Writes save data to file
func _write_save_file(data: Dictionary) -> bool:
	var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)

	if file == null:
		push_error("SaveSystem: Failed to open save file for writing")
		return false

	file.store_var(data)
	file.close()

	game_saved.emit()
	print("SaveSystem: Game saved")
	return true

## Reads save data from file
func _read_save_file() -> Dictionary:
	var file = FileAccess.open(SAVE_PATH, FileAccess.READ)

	if file == null:
		push_error("SaveSystem: Failed to open save file for reading")
		return {}

	var data = file.get_var()
	file.close()

	if typeof(data) != TYPE_DICTIONARY:
		push_error("SaveSystem: Save file corrupted")
		return {}

	return data
