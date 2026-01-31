## DialogueManager - Manages dialogue display and choices
## Handles JSON-based dialogue trees
extends Node

## Emitted when dialogue starts
signal dialogue_started(dialogue_id: String)

## Emitted when dialogue line displayed
signal line_displayed(speaker: String, text: String, emotion: String)

## Emitted when choices presented to player
signal choices_presented(choices: Array)

## Emitted when player selects choice
signal choice_selected(choice_id: String)

## Emitted when dialogue ends
signal dialogue_ended

## Current dialogue data
var current_dialogue: Dictionary = {}

## Current line index
var current_line_index: int = 0

## Is dialogue active
var is_active: bool = false

## Starts dialogue from JSON file
func start_dialogue(dialogue_path: String) -> bool:
	if is_active:
		push_warning("DialogueManager: Dialogue already active")
		return false

	# Load dialogue JSON
	var dialogue_data = _load_dialogue_file(dialogue_path)

	if dialogue_data.is_empty():
		push_error("DialogueManager: Failed to load dialogue '%s'" % dialogue_path)
		return false

	current_dialogue = dialogue_data
	current_line_index = 0
	is_active = true

	dialogue_started.emit(dialogue_path)
	EventBus.dialogue_started.emit(dialogue_path)

	# Display first line
	_display_current_line()

	return true

## Advances to next dialogue line
func next_line() -> void:
	if not is_active:
		return

	current_line_index += 1

	# Check if dialogue ended
	if current_line_index >= current_dialogue.get("dialogues", []).size():
		end_dialogue()
		return

	_display_current_line()

## Selects choice
func select_choice(choice_index: int) -> void:
	if not is_active:
		return

	var current_line = _get_current_line()

	if "choices" not in current_line:
		push_warning("DialogueManager: Current line has no choices")
		return

	var choices = current_line["choices"]

	if choice_index < 0 or choice_index >= choices.size():
		push_error("DialogueManager: Invalid choice index %d" % choice_index)
		return

	var choice = choices[choice_index]

	# Emit choice selected
	choice_selected.emit(choice.get("id", ""))
	EventBus.choice_selected.emit(choice.get("id", ""))

	# Apply choice effects
	_apply_choice_effects(choice)

	# Check if choice leads to another scene
	if "leads_to" in choice and choice["leads_to"] != null:
		start_dialogue(choice["leads_to"])
	else:
		end_dialogue()

## Ends current dialogue
func end_dialogue() -> void:
	if not is_active:
		return

	is_active = false
	current_dialogue.clear()
	current_line_index = 0

	dialogue_ended.emit()
	EventBus.dialogue_ended.emit()

## Gets current dialogue line
func _get_current_line() -> Dictionary:
	var dialogues = current_dialogue.get("dialogues", [])

	if current_line_index < 0 or current_line_index >= dialogues.size():
		return {}

	return dialogues[current_line_index]

## Displays current line
func _display_current_line() -> void:
	var line = _get_current_line()

	if line.is_empty():
		end_dialogue()
		return

	var speaker = line.get("speaker", "")
	var text = line.get("text", "")
	var emotion = line.get("emotion", "neutral")

	line_displayed.emit(speaker, text, emotion)

	# If line has choices, present them
	if "choices" in line:
		choices_presented.emit(line["choices"])

## Applies choice effects (flags, stat changes, etc.)
func _apply_choice_effects(choice: Dictionary) -> void:
	# Apply story flags
	if "flags" in choice:
		for flag in choice["flags"]:
			GameState.set_flag(flag, true)

	# Apply stat changes
	if "stat_changes" in choice:
		for stat_name in choice["stat_changes"]:
			var delta = choice["stat_changes"][stat_name]
			GameState.modify_stat(stat_name, delta)

## Loads dialogue from JSON file
func _load_dialogue_file(dialogue_path: String) -> Dictionary:
	# Construct full path
	var full_path = "res://data/narrative/dialogues/%s.json" % dialogue_path

	if not FileAccess.file_exists(full_path):
		push_error("DialogueManager: File not found '%s'" % full_path)
		return {}

	var file = FileAccess.open(full_path, FileAccess.READ)

	if file == null:
		push_error("DialogueManager: Failed to open file '%s'" % full_path)
		return {}

	var content = file.get_as_text()
	file.close()

	var parsed = JSON.parse_string(content)

	if typeof(parsed) != TYPE_DICTIONARY:
		push_error("DialogueManager: Invalid JSON in '%s'" % full_path)
		return {}

	return parsed
