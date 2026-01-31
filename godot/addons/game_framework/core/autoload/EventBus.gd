## EventBus - Global event system (Autoload singleton)
## Enables decoupled communication between systems
## Follows Dependency Inversion Principle
extends Node

# Define your game-specific signals here
# These are examples - add more as needed

## Player events
signal player_died
signal player_health_changed(current: int, maximum: int)
signal player_leveled_up(new_level: int)

## Game flow events
signal day_started(day_number: int)
signal day_ended(day_number: int)
signal game_over(ending_id: String)
signal game_won

## Narrative events
signal dialogue_started(dialogue_id: String)
signal dialogue_ended
signal choice_selected(choice_id: String)
signal story_flag_set(flag_name: String, value)

## UI events
signal menu_opened(menu_name: String)
signal menu_closed(menu_name: String)
signal notification_shown(message: String)

## Item/Inventory events
signal item_collected(item_id: String)
signal item_used(item_id: String)
signal inventory_changed

## Audio events
signal music_requested(track_name: String)
signal sfx_requested(sound_name: String)

## Special events (game-specific)
signal special_event_triggered(event_id: String)

## Helper function to emit event with logging (debug)
func emit_debug(signal_name: String, args: Array = []):
	print("EventBus: Emitting '%s' with args: %s" % [signal_name, args])
	callv("emit_signal", [signal_name] + args)
