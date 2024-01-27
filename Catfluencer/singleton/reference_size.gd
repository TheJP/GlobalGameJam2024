extends Node


var rect: Rect2


func _ready():
	var screen: Polygon2D = get_tree().get_first_node_in_group("screen")
	rect = Rect2(INF,INF,-INF,-INF)
	if screen:
		for v in screen.polygon:
			rect.position.x = minf(rect.position.x, v.x)
			rect.position.y = minf(rect.position.y, v.y)
			rect.size.x = maxf(rect.size.x, v.x)
			rect.size.y = maxf(rect.size.y, v.y)
		rect.size -= rect.position
	else:
		rect = Rect2(0, 0, 1920, 1080)
