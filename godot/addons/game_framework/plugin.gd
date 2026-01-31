@tool
extends EditorPlugin

## Game Framework Plugin
## Initializes the global reusable framework for story-driven games

func _enter_tree() -> void:
	print("Game Framework: Plugin enabled")
	_register_autoload_singletons()
	print("Game Framework: Initialization complete")

func _exit_tree() -> void:
	print("Game Framework: Plugin disabled")
	_unregister_autoload_singletons()

## Registers autoload singletons
func _register_autoload_singletons() -> void:
	# Register core autoloads
	add_autoload_singleton("EventBus", "res://addons/game_framework/core/autoload/EventBus.gd")
	add_autoload_singleton("GameState", "res://addons/game_framework/core/autoload/GameState.gd")
	add_autoload_singleton("SaveSystem", "res://addons/game_framework/core/autoload/SaveSystem.gd")

	print("Game Framework: Autoload singletons registered")

## Unregisters autoload singletons
func _unregister_autoload_singletons() -> void:
	# Remove core autoloads
	remove_autoload_singleton("EventBus")
	remove_autoload_singleton("GameState")
	remove_autoload_singleton("SaveSystem")

	print("Game Framework: Autoload singletons unregistered")
