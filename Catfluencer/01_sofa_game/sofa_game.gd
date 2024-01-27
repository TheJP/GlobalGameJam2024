extends Node2D


func _ready():
	var new_size: Vector2 = Vector2(1.0, 0.1) * ReferenceSize.rect.size
	$Slider.fit_into(ReferenceSize.rect.position + ReferenceSize.rect.size - new_size, new_size)


func _on_slider_value_changed(new_value):
	pass
