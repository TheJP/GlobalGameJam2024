class_name Makeup
extends Area2D


enum Type {
	Colour,
	Lipstick,
	EyeShadow,
}


signal selected(makeup: Node2D, type: Type, line_width: float, colour: Color)
@export var type: Type = Type.Colour
@export var line_width: float = 1.0
@export var colour: Color = Color.BLACK
var _hovered = false
var _disabled = false


func _input(event):
	if event is InputEventMouseButton:
		if not event.pressed or event.button_index != MOUSE_BUTTON_LEFT:
			return
		if not _hovered or _disabled:
			return

		selected.emit(self, type, line_width, colour)


func _on_mouse_entered():
	if _disabled:
		return

	_hovered = true
	Input.set_default_cursor_shape(Input.CURSOR_POINTING_HAND)


func _on_mouse_exited():
	if _disabled:
		return

	_hovered = false
	Input.set_default_cursor_shape(Input.CURSOR_ARROW)


func disable():
	_disabled = true
	Input.set_default_cursor_shape(Input.CURSOR_ARROW)
