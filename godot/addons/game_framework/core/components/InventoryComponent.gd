## InventoryComponent - Reusable inventory management
## Follows Single Responsibility Principle - ONLY manages items
class_name InventoryComponent
extends Node

## Emitted when item added to inventory
signal item_added(item: Dictionary, quantity: int)

## Emitted when item removed from inventory
signal item_removed(item_id: String, quantity: int)

## Emitted when inventory changes
signal inventory_changed

## Maximum number of different item types
@export var max_item_types: int = 20

## Items stored as Dictionary: {item_id: {data: {...}, quantity: int}}
var _items: Dictionary = {}

## Adds item to inventory
## Returns true if successful
func add_item(item_data: Dictionary, quantity: int = 1) -> bool:
	if quantity <= 0:
		push_warning("InventoryComponent: Quantity must be positive")
		return false

	if "id" not in item_data:
		push_error("InventoryComponent: Item must have 'id' field")
		return false

	var item_id = item_data["id"]

	# Check if item already exists
	if item_id in _items:
		_items[item_id]["quantity"] += quantity
	else:
		# Check max types limit
		if _items.size() >= max_item_types:
			push_warning("InventoryComponent: Inventory full (max types reached)")
			return false

		_items[item_id] = {
			"data": item_data,
			"quantity": quantity
		}

	item_added.emit(item_data, quantity)
	inventory_changed.emit()
	return true

## Removes item from inventory
## Returns true if successful
func remove_item(item_id: String, quantity: int = 1) -> bool:
	if quantity <= 0:
		push_warning("InventoryComponent: Quantity must be positive")
		return false

	if item_id not in _items:
		push_warning("InventoryComponent: Item '%s' not in inventory" % item_id)
		return false

	var current_quantity = _items[item_id]["quantity"]

	if quantity > current_quantity:
		push_warning("InventoryComponent: Not enough items (%d available)" % current_quantity)
		return false

	_items[item_id]["quantity"] -= quantity

	# Remove entry if quantity reaches 0
	if _items[item_id]["quantity"] == 0:
		_items.erase(item_id)

	item_removed.emit(item_id, quantity)
	inventory_changed.emit()
	return true

## Checks if item exists in inventory
func has_item(item_id: String, min_quantity: int = 1) -> bool:
	if item_id not in _items:
		return false

	return _items[item_id]["quantity"] >= min_quantity

## Gets item quantity
func get_item_quantity(item_id: String) -> int:
	if item_id not in _items:
		return 0

	return _items[item_id]["quantity"]

## Gets item data
func get_item_data(item_id: String) -> Dictionary:
	if item_id not in _items:
		return {}

	return _items[item_id]["data"]

## Gets all items as array
func get_all_items() -> Array:
	var items_array = []

	for item_id in _items:
		items_array.append({
			"id": item_id,
			"data": _items[item_id]["data"],
			"quantity": _items[item_id]["quantity"]
		})

	return items_array

## Gets total number of item types
func get_item_type_count() -> int:
	return _items.size()

## Checks if inventory is full (max types)
func is_full() -> bool:
	return _items.size() >= max_item_types

## Checks if inventory is empty
func is_empty() -> bool:
	return _items.is_empty()

## Clears entire inventory
func clear() -> void:
	_items.clear()
	inventory_changed.emit()

## Serializes inventory for saving
func serialize() -> Dictionary:
	return {
		"items": _items,
		"max_item_types": max_item_types
	}

## Deserializes inventory from save data
func deserialize(data: Dictionary) -> void:
	if "max_item_types" in data:
		max_item_types = data["max_item_types"]

	if "items" in data:
		_items = data["items"]
		inventory_changed.emit()
