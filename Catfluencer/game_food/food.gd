extends Area2D


signal consume_food(food: Node2D, is_good: bool)


@export var is_good: bool = true
var _hovered: bool = false
var _consumed: bool = false
var _disabled: bool = false


func _input(event):
	if event is InputEventMouseButton:
		if not event.pressed or event.button_index != MOUSE_BUTTON_LEFT:
			return
		if not _hovered or _consumed or _disabled:
			return

		_consumed = true
		$Eaten.visible = true
		$NotEaten.visible = false
		Input.set_default_cursor_shape(Input.CURSOR_ARROW)
		consume_food.emit(self, is_good)


func _on_mouse_entered():
	if _consumed or _disabled:
		return

	_hovered = true
	Input.set_default_cursor_shape(Input.CURSOR_POINTING_HAND)


func _on_mouse_exited():
	if _consumed or _disabled:
		return

	_hovered = false
	Input.set_default_cursor_shape(Input.CURSOR_ARROW)


func disable():
	_disabled = true
	Input.set_default_cursor_shape(Input.CURSOR_ARROW)
