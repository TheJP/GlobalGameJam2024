extends Node2D


var _cat_hovered: bool = false
var _cat_jumped: bool = false


func _input(event):
	if event is InputEventMouseButton:
		if event.button_index != MOUSE_BUTTON_LEFT or not event.pressed:
			return
		if not _cat_hovered or _cat_jumped:
			return

		_cat_jumped = true
		$Slider.disabled = true
		$Cat.apply_impulse(Vector2(200, -1000))
		print("jump value: ", $Slider.value)

		await get_tree().create_timer(2.0, false).timeout
		var is_funny = 0.2 <= $Slider.value and $Slider.value <= 0.5
		Level.display_message("Funny" if is_funny else "Not Funny")
		Level.finished_level(is_funny)


func _ready():
	var new_size: Vector2 = Vector2(1.0, 0.1) * ReferenceSize.rect.size
	$Slider.fit_into(ReferenceSize.rect.position + ReferenceSize.rect.size - new_size, new_size)
	$Couch.global_position = ReferenceSize.rect.position + 0.5 * ReferenceSize.rect.size


func _on_slider_value_changed(new_value):
	$Couch.global_position = ReferenceSize.rect.position + 0.5 * ReferenceSize.rect.size
	$Couch.global_position.x += new_value * 0.5 * ReferenceSize.rect.size.x


func _on_cat_mouse_entered():
	_cat_hovered = true
	Input.set_default_cursor_shape(Input.CURSOR_POINTING_HAND)


func _on_cat_mouse_exited():
	_cat_hovered = false
	Input.set_default_cursor_shape(Input.CURSOR_ARROW)
