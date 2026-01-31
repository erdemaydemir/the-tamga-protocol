extends Node

## DayCycleController - The Tamga Protocol
## Manages the 60-day game cycle

signal day_started(day_number: int)
signal day_ended(day_number: int)
signal game_over(reason: String)

enum TimeOfDay { MORNING, AFTERNOON, EVENING, NIGHT }

var current_time: TimeOfDay = TimeOfDay.MORNING

func _ready():
	# Connect to EventBus
	EventBus.day_started.connect(_on_day_started)

	# Start first day
	start_day()

func start_day():
	var day = GameState.current_day

	print("=== DAY %d / 60 ===" % day)

	# Check game over conditions
	if GameState.get_stat("health") <= 0:
		trigger_game_over("health_depleted")
		return

	if GameState.get_stat("morale") <= 0:
		trigger_game_over("morale_depleted")
		return

	if day > 60:
		trigger_ending()
		return

	# Emit day started
	current_time = TimeOfDay.MORNING
	day_started.emit(day)
	EventBus.day_started.emit(day)

	# TODO: Load day events
	# var event_data = load_day_events(day)
	# process_morning_event(event_data)

	print("  Health: %d" % GameState.get_stat("health"))
	print("  Morale: %d" % GameState.get_stat("morale"))

func advance_time():
	match current_time:
		TimeOfDay.MORNING:
			current_time = TimeOfDay.AFTERNOON
			print("  → Afternoon")
		TimeOfDay.AFTERNOON:
			current_time = TimeOfDay.EVENING
			print("  → Evening")
		TimeOfDay.EVENING:
			current_time = TimeOfDay.NIGHT
			print("  → Night")
			end_day()

func end_day():
	var day = GameState.current_day

	print("  Day %d ended" % day)

	# Auto-save
	SaveSystem.auto_save()
	print("  Game auto-saved")

	# Emit day ended
	day_ended.emit(day)
	EventBus.day_ended.emit(day)

	# Advance to next day
	GameState.advance_day()

	# Wait a moment, then start next day
	await get_tree().create_timer(1.0).timeout
	start_day()

func trigger_game_over(reason: String):
	print("=== GAME OVER ===")
	print("Reason: %s" % reason)

	game_over.emit(reason)
	EventBus.game_over.emit("the_lost")

	# TODO: Show game over screen
	# get_tree().change_scene_to_file("res://scenes/ui/game_over.tscn")

func trigger_ending():
	print("=== DAY 60 REACHED ===")
	print("Calculating ending...")

	# TODO: Calculate ending based on flags, relationships, clues
	# For now, just print stats
	print("  Clues discovered: %d" % GameState.discovered_clues.size())
	print("  Story flags: %d" % GameState.story_flags.size())

	# Trigger ending
	var ending_id = "the_survivor"  # TODO: Calculate actual ending
	EventBus.game_over.emit(ending_id)

	print("Ending: %s" % ending_id)

func _on_day_started(day: int):
	print("  EventBus: Day %d started signal received" % day)

## Load day events from JSON
func load_day_events(day: int) -> Array:
	# TODO: Load from data/events/day_events.json
	# Filter events by day_trigger == day
	return []

## Process morning event
func process_morning_event(event_data: Dictionary):
	# TODO: Implement event processing
	pass
