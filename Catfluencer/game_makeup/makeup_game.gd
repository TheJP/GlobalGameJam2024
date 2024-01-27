extends Node2D


var _used_makeup_types: Array[Makeup.Type] = []
var _has_selected = false
var _type: Makeup.Type
var _line_width: float
var _colour: Color

var _hover: bool = false
var _pen_down: bool = false
var _last_position: Vector2
var _finished_level = false


func _ready():
	Level.start_timer(10.0, disable_makeups)
	for makeup: Makeup in get_tree().get_nodes_in_group("makeup"):
		makeup.selected.connect(_on_makeup_selected)


func _input(event):
	if event is InputEventMouseButton:
		if event.button_index != MOUSE_BUTTON_LEFT:
			return

		if not event.pressed:
			_pen_down = false
			return

		if not _hover or not _has_selected:
			return

		_pen_down = true
		_last_position = event.position
	elif event is InputEventMouseMotion:
		if not _pen_down or not _has_selected:
			return

		if _line_width < 15:
			$Canvas.add_line(_last_position, event.position, _colour, _line_width)
		else:
			$Canvas.add_circle(event.position, _colour, _line_width)
		_last_position = event.position

		if not _used_makeup_types.has(_type):
			_used_makeup_types.push_back(_type)
		if len(_used_makeup_types) >= len(Makeup.Type) and not _finished_level:
			Level.stop_timer()
			disable_makeups()
			await get_tree().create_timer(2.0).timeout
			Level.display_message("Awesome\nLook!")
			Level.finished_level(true)
			return


func _on_makeup_selected(makeup, type, line_width, colour):
	_has_selected = true
	_type = type
	_line_width = line_width
	_colour = colour


func _on_cat_head_mouse_entered():
	_hover = true


func _on_cat_head_mouse_exited():
	_hover = false
	_pen_down = false


func disable_makeups():
	_finished_level = true
	for makeup in get_tree().get_nodes_in_group("makeup"):
		makeup.disable()
