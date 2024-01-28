extends Node2D


var good_food_count = 0
var _last_eaten: float = INF


func _ready():
	Level.start_timer(10.0, disable_foods)

	for food in get_tree().get_nodes_in_group("food"):
		if food.is_good:
			good_food_count += 1
		food.consume_food.connect(_on_consume_food)


func _process(delta):
	_last_eaten += delta
	if _last_eaten <= 1.5:
		if $Cat/AnimatedSprite2D.animation != "eat":
			$Cat/AnimatedSprite2D.animation = "eat"
	elif $Cat/AnimatedSprite2D.animation == "eat":
		$Cat/AnimatedSprite2D.animation = "default"


func _on_consume_food(food, is_good):
	_last_eaten = 0
	if not is_good:
		#Level.display_message("Diarrhea")
		$Diarrhea.visible = true
		Level.finished_level(false)
		Reactions.diarrhea()
		return

	#food.get_node("Sprite2D").visible = false
	good_food_count -= 1
	
	if good_food_count <= 0:
		Level.display_message("Yummy!")
		Level.finished_level(true)


func disable_foods():
	for food in get_tree().get_nodes_in_group("food"):
		food.disable()
