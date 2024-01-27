extends Area2D


signal consume_food(food: Node2D, is_good: bool)


@export var is_good: bool = true
var _hovered: bool = false
var _consumed: bool = false


func _input(event):
	if event is InputEventMouseButton:
		if not event.pressed or event.button_index != MOUSE_BUTTON_LEFT:
			return
		if not _hovered or _consumed:
			return

		_consumed = true
		Input.set_default_cursor_shape(Input.CURSOR_ARROW)
		consume_food.emit(self, is_good)


func _on_mouse_entered():
	if _consumed:
		return

	_hovered = true
	Input.set_default_cursor_shape(Input.CURSOR_POINTING_HAND)


func _on_mouse_exited():
	if _consumed:
		return

	_hovered = false
	Input.set_default_cursor_shape(Input.CURSOR_ARROW)
