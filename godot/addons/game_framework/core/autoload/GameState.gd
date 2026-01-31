## GameState - Global game state manager (Autoload singleton)
## Manages game-wide state, flags, and variables
extends Node

## Current day (for day-based games like 60 Seconds)
var current_day: int = 1

## Story flags (Dictionary of flag_name → value)
var story_flags: Dictionary = {}

## Player stats
var player_stats: Dictionary = {
	"health": 100,
	"hunger": 0,
	"morale": 50
}

## Inventory reference (if using separate inventory system)
var inventory_data: Dictionary = {}

## Discovered clues
var discovered_clues: Array = []

## Relationships (NPC_name → relationship_value)
var relationships: Dictionary = {}

## Accessible endings
var accessible_endings: Array = []

## Game started timestamp
var game_start_time: String = ""

## Adds or updates story flag
func set_flag(flag_name: String, value) -> void:
	story_flags[flag_name] = value
	EventBus.story_flag_set.emit(flag_name, value)

## Gets story flag value
func get_flag(flag_name: String, default_value = null):
	return story_flags.get(flag_name, default_value)

## Checks if story flag exists and is true
func has_flag(flag_name: String) -> bool:
	return story_flags.get(flag_name, false) == true

## Removes story flag
func clear_flag(flag_name: String) -> void:
	story_flags.erase(flag_name)

## Sets player stat
func set_stat(stat_name: String, value) -> void:
	player_stats[stat_name] = value

## Gets player stat
func get_stat(stat_name: String, default_value = 0):
	return player_stats.get(stat_name, default_value)

## Modifies player stat by delta
func modify_stat(stat_name: String, delta) -> void:
	if stat_name not in player_stats:
		push_warning("GameState: Stat '%s' does not exist" % stat_name)
		return

	player_stats[stat_name] += delta

## Adds discovered clue
func add_clue(clue_id: String) -> void:
	if clue_id not in discovered_clues:
		discovered_clues.append(clue_id)

## Checks if clue discovered
func has_clue(clue_id: String) -> bool:
	return clue_id in discovered_clues

## Sets relationship value
func set_relationship(npc_name: String, value: int) -> void:
	relationships[npc_name] = clamp(value, -100, 100)

## Gets relationship value
func get_relationship(npc_name: String) -> int:
	return relationships.get(npc_name, 0)

## Modifies relationship
func modify_relationship(npc_name: String, delta: int) -> void:
	var current = get_relationship(npc_name)
	set_relationship(npc_name, current + delta)

## Advances to next day
func advance_day() -> void:
	current_day += 1
	EventBus.day_started.emit(current_day)

## Resets game state (new game)
func reset() -> void:
	current_day = 1
	story_flags.clear()
	player_stats = {
		"health": 100,
		"hunger": 0,
		"morale": 50
	}
	inventory_data.clear()
	discovered_clues.clear()
	relationships.clear()
	accessible_endings.clear()
	game_start_time = Time.get_datetime_string_from_system()

## Serializes game state for saving
func serialize() -> Dictionary:
	return {
		"current_day": current_day,
		"story_flags": story_flags,
		"player_stats": player_stats,
		"inventory_data": inventory_data,
		"discovered_clues": discovered_clues,
		"relationships": relationships,
		"accessible_endings": accessible_endings,
		"game_start_time": game_start_time
	}

## Deserializes game state from save
func deserialize(data: Dictionary) -> void:
	if "current_day" in data:
		current_day = data["current_day"]

	if "story_flags" in data:
		story_flags = data["story_flags"]

	if "player_stats" in data:
		player_stats = data["player_stats"]

	if "inventory_data" in data:
		inventory_data = data["inventory_data"]

	if "discovered_clues" in data:
		discovered_clues = data["discovered_clues"]

	if "relationships" in data:
		relationships = data["relationships"]

	if "accessible_endings" in data:
		accessible_endings = data["accessible_endings"]

	if "game_start_time" in data:
		game_start_time = data["game_start_time"]
