extends Node2D


var _entries = []


func _draw():
	for entry in _entries:
		if entry.shape == "line":
			draw_line(entry.from, entry.to, entry.colour, entry.line_width, true)
		else:
			draw_circle(entry.centre, entry.radius, entry.colour)


func add_line(from: Vector2, to: Vector2, colour: Color, line_width: float):
	_entries.push_back({ "shape": "line", "from": from, "to": to, "colour": colour, "line_width": line_width })
	queue_redraw()


func add_circle(centre: Vector2, colour: Color, radius: float):
	_entries.push_back({ "shape": "circle", "centre": centre, "colour": colour, "radius": radius })
	queue_redraw()
