extends Node2D


var _couch_origin: Vector2
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
		$Cat/CollisionShape2DSit.set_deferred("disabled", true)
		$Cat/CollisionShape2DJump.set_deferred("disabled", false)
		$Cat/AnimatedSprite2D.animation = "jump"
		$Cat.apply_impulse(Vector2(250, -1200))
		Audio.play_neutral_sound()
		print("jump value: ", $Slider.value)

		await get_tree().create_timer(2.0, false).timeout
		var is_funny = 0.37 <= $Slider.value and $Slider.value <= 0.6
		$Funny.visible = is_funny
		$NotFunny.visible = not is_funny
		Level.finished_level(is_funny)


func _ready():
	_couch_origin = $Couch.position
	if Time.get_ticks_msec() > 10000:
		%HintButton.visible = true
	create_tween().tween_callback(func(): %HintButton.visible = true).set_delay(10.0)


func _on_slider_value_changed(new_value):
	$Couch.position = _couch_origin
	$Couch.global_position.x += new_value * 0.5 * ReferenceSize.rect.size.x


func _on_cat_mouse_entered():
	_cat_hovered = true
	Input.set_default_cursor_shape(Input.CURSOR_POINTING_HAND)


func _on_cat_mouse_exited():
	_cat_hovered = false
	Input.set_default_cursor_shape(Input.CURSOR_ARROW)


func _on_cat_body_entered(body):
	if body == $Floor and _cat_jumped:
		$Cat/AnimatedSprite2D.animation = "sit"
		$Cat/CollisionShape2DSit.set_deferred("disabled", false)
		$Cat/CollisionShape2DJump.set_deferred("disabled", true)


func _on_hint_button_mouse_entered():
	%Hint.visible = true


func _on_hint_button_mouse_exited():
	%Hint.visible = false
