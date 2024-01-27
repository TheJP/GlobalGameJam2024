class_name Package
extends Node2D


signal finished_package(package: Node2D)
signal destroyed_content(package: Node2D)


@export var package_layers: int = 3
var has_destroyed_content: bool = false
var _hovered = false
var _disabled = false


func _input(event):
	if event is InputEventMouseButton:
		if not event.pressed or event.button_index != MOUSE_BUTTON_LEFT:
			return
		if has_destroyed_content or not _hovered or _disabled:
			return

		if package_layers <= 0:
			has_destroyed_content = true
			$Content.modulate = Color.FIREBRICK
			_hovered = false
			Input.set_default_cursor_shape(Input.CURSOR_ARROW)
			destroyed_content.emit(self)
			return

		package_layers -= 1
		if package_layers <= 0:
			$Cardboard.visible = false
			finished_package.emit(self)
		else:
			$Cardboard.scale *= 0.5



func _on_mouse_entered():
	if has_destroyed_content or _disabled:
		return

	_hovered = true
	Input.set_default_cursor_shape(Input.CURSOR_POINTING_HAND)


func _on_mouse_exited():
	if has_destroyed_content or _disabled:
		return

	_hovered = false
	Input.set_default_cursor_shape(Input.CURSOR_ARROW)


func disable():
	_disabled = true
	Input.set_default_cursor_shape(Input.CURSOR_ARROW)
