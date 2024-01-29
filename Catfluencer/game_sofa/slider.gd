extends Node2D


signal value_changed(new_value: float)


var disabled: bool = false
var value: float = 0
var max_value: float = 1
var _left: Vector2
var _right: Vector2
var _hover_grabber: bool = false
var _hover_bar: bool = false
var _dragging: bool = false
var _drag_origin: float
var _modulate_grabber: Color = Color.hex(0xe18aa5ff)


func _ready():
	_left = $Grabber.position
	_right = $Grabber.position
	_right.x *= -1


func _input(event):
	if disabled:
		_dragging = false
		return

	if event is InputEventMouseButton:
		if event.button_index != MOUSE_BUTTON_LEFT:
			return

		if event.pressed and _hover_grabber:
			_dragging = true
			_drag_origin = event.position.x - $Grabber.position.x
		elif event.pressed and _hover_bar:
			_dragging = true
			_drag_origin = position.x
			_update_grabber_position(event.position.x - position.x)

		if not event.pressed:
			_dragging = false

	if event is InputEventMouseMotion:
		if _dragging:
			_update_grabber_position(event.position.x - _drag_origin)


func _update_grabber_position(new_unbound: float):
	var new_bound = clamp(new_unbound, _left.x, _right.x)
	$Grabber.position.x = new_bound
	value = (new_bound - _left.x) / (_right.x - _left.x) * max_value
	value_changed.emit(value)


func _on_grabber_mouse_entered():
	_hover_grabber = true


func _on_grabber_mouse_exited():
	_hover_grabber = false


func _on_slider_bar_mouse_entered():
	_hover_bar = true


func _on_slider_bar_mouse_exited():
	_hover_bar = false


func _update_hover_state():
	if _hover_grabber or _hover_bar:
		Input.set_default_cursor_shape(Input.CURSOR_POINTING_HAND)
	else:
		Input.set_default_cursor_shape(Input.CURSOR_ARROW)
