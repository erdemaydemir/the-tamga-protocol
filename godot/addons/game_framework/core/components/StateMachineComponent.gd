## StateMachineComponent - Generic state machine
## Follows Open/Closed Principle - extendable via state classes
class_name StateMachineComponent
extends Node

## Emitted when state changes
signal state_changed(old_state: String, new_state: String)

## Current state name
var current_state: String = ""

## Previous state name
var previous_state: String = ""

## Dictionary of state name → state node
var _states: Dictionary = {}

## Reference to owner entity
var _owner: Node

func _ready():
	_owner = get_parent()

	# Find all child nodes (states)
	for child in get_children():
		if child.has_method("enter") and child.has_method("exit"):
			_states[child.name] = child
		else:
			push_warning("StateMachineComponent: Child '%s' is not a valid state (missing enter/exit)" % child.name)

	# Start with first state if available
	if not _states.is_empty() and current_state == "":
		change_state(_states.keys()[0])

func _physics_process(delta):
	if current_state == "":
		return

	# Call current state's update
	var state = _states.get(current_state)
	if state and state.has_method("update"):
		state.update(delta)

## Changes to new state
## Returns true if successful
func change_state(new_state_name: String) -> bool:
	# Validate new state exists
	if new_state_name not in _states:
		push_error("StateMachineComponent: State '%s' does not exist" % new_state_name)
		return false

	# Exit current state
	if current_state != "":
		var old_state = _states[current_state]
		if old_state.has_method("exit"):
			old_state.exit()

	# Change state
	previous_state = current_state
	current_state = new_state_name

	# Enter new state
	var new_state = _states[new_state_name]
	if new_state.has_method("enter"):
		new_state.enter()

	state_changed.emit(previous_state, current_state)
	return true

## Returns to previous state
func return_to_previous() -> bool:
	if previous_state == "":
		push_warning("StateMachineComponent: No previous state")
		return false

	return change_state(previous_state)

## Gets current state node
func get_current_state_node() -> Node:
	if current_state == "":
		return null

	return _states.get(current_state)

## Checks if currently in specific state
func is_in_state(state_name: String) -> bool:
	return current_state == state_name

## Gets all available state names
func get_available_states() -> Array:
	return _states.keys()

## Serializes state machine
func serialize() -> Dictionary:
	return {
		"current_state": current_state,
		"previous_state": previous_state
	}

## Deserializes state machine
func deserialize(data: Dictionary) -> void:
	if "current_state" in data and data["current_state"] in _states:
		change_state(data["current_state"])

	if "previous_state" in data:
		previous_state = data["previous_state"]
