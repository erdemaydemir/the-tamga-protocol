## HealthComponent - Reusable health management component
## Follows Single Responsibility Principle - ONLY manages health
class_name HealthComponent
extends Node

## Emitted when health changes
signal health_changed(new_health: int, max_health: int)

## Emitted when entity dies (health reaches 0)
signal died

## Emitted when entity takes damage
signal took_damage(amount: int)

## Emitted when entity heals
signal healed(amount: int)

## Maximum health
@export var max_health: int = 100

## Current health (read-only, use functions to modify)
var current_health: int:
	get:
		return _current_health
	set(value):
		push_error("HealthComponent: Use take_damage() or heal() to modify health")

var _current_health: int = 0

func _ready():
	_current_health = max_health
	health_changed.emit(_current_health, max_health)

## Takes damage and emits signals
## Returns true if entity died
func take_damage(amount: int) -> bool:
	if amount <= 0:
		push_warning("HealthComponent: Damage amount must be positive")
		return false

	if not is_alive():
		return false  # Already dead

	_current_health = max(0, _current_health - amount)
	took_damage.emit(amount)
	health_changed.emit(_current_health, max_health)

	if _current_health == 0:
		died.emit()
		return true

	return false

## Heals entity
## Cannot exceed max_health
func heal(amount: int) -> void:
	if amount <= 0:
		push_warning("HealthComponent: Heal amount must be positive")
		return

	if not is_alive():
		push_warning("HealthComponent: Cannot heal dead entity")
		return

	var old_health = _current_health
	_current_health = min(max_health, _current_health + amount)

	var actual_heal = _current_health - old_health
	if actual_heal > 0:
		healed.emit(actual_heal)
		health_changed.emit(_current_health, max_health)

## Returns true if entity is alive
func is_alive() -> bool:
	return _current_health > 0

## Returns current health percentage (0.0 to 1.0)
func get_health_percent() -> float:
	if max_health == 0:
		return 0.0
	return float(_current_health) / float(max_health)

## Sets health directly (use sparingly)
## Primarily for loading save data
func set_health_direct(value: int) -> void:
	_current_health = clamp(value, 0, max_health)
	health_changed.emit(_current_health, max_health)

	if _current_health == 0:
		died.emit()

## Resets health to maximum
func reset_to_max() -> void:
	_current_health = max_health
	health_changed.emit(_current_health, max_health)

## Gets serializable data for saving
func serialize() -> Dictionary:
	return {
		"current_health": _current_health,
		"max_health": max_health
	}

## Restores from serialized data
func deserialize(data: Dictionary) -> void:
	if "max_health" in data:
		max_health = data["max_health"]

	if "current_health" in data:
		set_health_direct(data["current_health"])
