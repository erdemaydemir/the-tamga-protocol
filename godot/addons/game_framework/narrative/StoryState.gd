## StoryState - Tracks story progression and ending calculation
## Works with Story Agent and Story Validator
class_name StoryState
extends Node

## Current act (1, 2, 3, 4, etc.)
var current_act: int = 1

## Active plot threads
var active_plot_threads: Array = []

## Completed plot threads
var completed_plot_threads: Array = []

## Clue network (clue_id → discovery data)
var clues: Dictionary = {}

## Character knowledge (character_name → {known_facts: []})
var character_knowledge: Dictionary = {}

## Ending scores (ending_id → score)
var ending_scores: Dictionary = {}

## Tracks which character knows what fact
func set_character_knowledge(character_name: String, fact: String) -> void:
	if character_name not in character_knowledge:
		character_knowledge[character_name] = {"known_facts": []}

	if fact not in character_knowledge[character_name]["known_facts"]:
		character_knowledge[character_name]["known_facts"].append(fact)

## Checks if character knows fact
func character_knows(character_name: String, fact: String) -> bool:
	if character_name not in character_knowledge:
		return false

	return fact in character_knowledge[character_name].get("known_facts", [])

## Discovers clue
func discover_clue(clue_id: String, day: int) -> void:
	if clue_id not in clues:
		clues[clue_id] = {
			"discovered_on_day": day,
			"timestamp": Time.get_ticks_msec()
		}

		GameState.add_clue(clue_id)

## Checks if clue discovered
func has_clue(clue_id: String) -> bool:
	return clue_id in clues

## Starts plot thread
func start_plot_thread(thread_id: String) -> void:
	if thread_id not in active_plot_threads:
		active_plot_threads.append(thread_id)

## Completes plot thread
func complete_plot_thread(thread_id: String) -> void:
	if thread_id in active_plot_threads:
		active_plot_threads.erase(thread_id)

	if thread_id not in completed_plot_threads:
		completed_plot_threads.append(thread_id)

## Checks if plot thread active
func is_plot_thread_active(thread_id: String) -> bool:
	return thread_id in active_plot_threads

## Updates ending score
func update_ending_score(ending_id: String, delta: int) -> void:
	if ending_id not in ending_scores:
		ending_scores[ending_id] = 0

	ending_scores[ending_id] += delta

## Gets ending score
func get_ending_score(ending_id: String) -> int:
	return ending_scores.get(ending_id, 0)

## Calculates most likely ending based on scores
func calculate_likely_ending() -> String:
	if ending_scores.is_empty():
		return ""

	var highest_score = -999999
	var best_ending = ""

	for ending_id in ending_scores:
		if ending_scores[ending_id] > highest_score:
			highest_score = ending_scores[ending_id]
			best_ending = ending_id

	return best_ending

## Gets all possible endings (score > 0)
func get_possible_endings() -> Array:
	var possible = []

	for ending_id in ending_scores:
		if ending_scores[ending_id] > 0:
			possible.append(ending_id)

	return possible

## Serializes story state for saving
func serialize() -> Dictionary:
	return {
		"current_act": current_act,
		"active_plot_threads": active_plot_threads,
		"completed_plot_threads": completed_plot_threads,
		"clues": clues,
		"character_knowledge": character_knowledge,
		"ending_scores": ending_scores
	}

## Deserializes story state from save
func deserialize(data: Dictionary) -> void:
	if "current_act" in data:
		current_act = data["current_act"]

	if "active_plot_threads" in data:
		active_plot_threads = data["active_plot_threads"]

	if "completed_plot_threads" in data:
		completed_plot_threads = data["completed_plot_threads"]

	if "clues" in data:
		clues = data["clues"]

	if "character_knowledge" in data:
		character_knowledge = data["character_knowledge"]

	if "ending_scores" in data:
		ending_scores = data["ending_scores"]
