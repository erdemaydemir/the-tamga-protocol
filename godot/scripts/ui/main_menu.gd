extends Control

## Main Menu - The Tamga Protocol
## Handles main menu UI and transitions

@onready var continue_button = $VBoxContainer/ContinueButton

func _ready():
	# Check if save file exists
	if SaveSystem.has_save():
		continue_button.disabled = false
	else:
		continue_button.disabled = true

	# Test framework integration
	print("=== The Tamga Protocol ===")
	print("Framework Integration Test:")
	print("  EventBus: ", EventBus != null)
	print("  GameState: ", GameState != null)
	print("  SaveSystem: ", SaveSystem != null)
	print("  Save file exists: ", SaveSystem.has_save())

func _on_new_game_pressed():
	print("New Game started")

	# Reset game state
	GameState.reset()
	GameState.current_day = 1

	# Emit event
	EventBus.day_started.emit(1)

	# Load day cycle scene
	get_tree().change_scene_to_file("res://scenes/gameplay/day_cycle.tscn")

func _on_continue_pressed():
	print("Continue game")

	if SaveSystem.load_game():
		print("Game loaded successfully")
		print("Current day: ", GameState.current_day)

		# Load game scene
		get_tree().change_scene_to_file("res://scenes/gameplay/day_cycle.tscn")
	else:
		print("Failed to load game")

func _on_settings_pressed():
	print("Settings - TODO: Implement settings menu")

func _on_quit_pressed():
	print("Quit game")
	get_tree().quit()
