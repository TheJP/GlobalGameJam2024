extends Node2D


var good_food_count = 0


func _ready():
	for food in get_tree().get_nodes_in_group("food"):
		if food.is_good:
			good_food_count += 1
		food.consume_food.connect(_on_consume_food)


func _on_consume_food(food, is_good):
	var message = get_tree().get_first_node_in_group("message")
	if not is_good:
		if message:
			message.text = "Diarrhea"

		Level.finished_level(false)
		return

	food.get_node("Sprite2D").visible = false
	good_food_count -= 1
	
	if good_food_count <= 0:
		if message:
			message.text = "Yummy!"

		Level.finished_level(true)
