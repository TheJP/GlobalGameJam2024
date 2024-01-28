class_name Package
extends Node2D


signal finished_package(package: Node2D)
signal destroyed_content(package: Node2D)


@export var textures: Array[Texture] = []
var package_layer = 0
var has_destroyed_content: bool = false
var _hovered = false
var _disabled = false


func _process(delta):
	$Sprite2D.texture = textures[package_layer]


func _input(event):
	if event is InputEventMouseButton:
		if not event.pressed or event.button_index != MOUSE_BUTTON_LEFT:
			return
		if has_destroyed_content or not _hovered or _disabled:
			return

		if package_layer + 1 >= len(textures):
			return
		package_layer += 1

		if package_layer + 1 >= len(textures):
			has_destroyed_content = true
			unhover()
			destroyed_content.emit(self)
			return

		if package_layer + 2 == len(textures):
			finished_package.emit(self)



func _on_mouse_entered():
	if has_destroyed_content or _disabled:
		return

	_hovered = true
	scale = Vector2(1.1, 1.1)
	Input.set_default_cursor_shape(Input.CURSOR_POINTING_HAND)


func _on_mouse_exited():
	if has_destroyed_content or _disabled:
		return

	unhover()


func disable():
	_disabled = true
	unhover()


func unhover():
	_hovered = false
	scale = Vector2(1, 1)
	Input.set_default_cursor_shape(Input.CURSOR_ARROW)
