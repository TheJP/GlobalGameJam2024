extends Node2D


var good_food_count = 0


func _ready():
	Level.start_timer(5, disable_foods)

	for food in get_tree().get_nodes_in_group("food"):
		if food.is_good:
			good_food_count += 1
		food.consume_food.connect(_on_consume_food)


func _on_consume_food(food, is_good):
	if not is_good:
		Level.display_message("Diarrhea")
		Level.finished_level(false)
		return

	food.get_node("Sprite2D").visible = false
	good_food_count -= 1
	
	if good_food_count <= 0:
		Level.display_message("Yummy!")
		Level.finished_level(true)


func disable_foods():
	for food in get_tree().get_nodes_in_group("food"):
		food.disable()
