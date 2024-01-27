extends Node2D


signal value_changed(new_value: float)


var value: float = 0
var max_value: float = 1
var _left: Vector2
var _right: Vector2
var _mouse_inside: bool = false
var _dragging: bool = false
var _drag_origin: float


func _input(event):
	if event is InputEventMouseButton:
		if event.button_index != MOUSE_BUTTON_LEFT:
			return

		if event.pressed and _mouse_inside:
			_dragging = true
			_drag_origin = event.global_position.x - $Grabber.global_position.x

		if not event.pressed:
			_dragging = false

	if event is InputEventMouseMotion:
		if not _dragging:
			return

		var new_unbound = event.global_position.x - _drag_origin
		var new_bound = clamp(new_unbound, _left.x, _right.x)
		$Grabber.global_position.x = new_bound
		value = (new_bound - _left.x) / (_right.x - _left.x) * max_value
		value_changed.emit(value)


func fit_into(new_position: Vector2, new_size: Vector2):
	var minSide = minf(new_size.x, new_size.y)
	var minSize = Vector2(minSide, minSide)
	_left = new_position + 0.5 * minSize;
	_right = new_position + new_size - 0.5 * minSize
	$Grabber.global_scale = minSize
	$Grabber.global_position = _left.lerp(_right, value / max_value)
	$Background.global_scale = new_size
	$Background.global_position = new_position


func _on_grabber_mouse_entered():
	_mouse_inside = true
	Input.set_default_cursor_shape(Input.CURSOR_POINTING_HAND)


func _on_grabber_mouse_exited():
	_mouse_inside = false
	Input.set_default_cursor_shape(Input.CURSOR_ARROW)
