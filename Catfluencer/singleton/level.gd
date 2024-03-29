extends Node


signal show_boring()


var remaining_time: float = 0
var _timed_level: bool = false
var _regular_flow = false
var _current = 0
var _timeout_callback: Callable


const _levels = [
	preload("res://game_sofa/sofa_game.tscn"),
	preload("res://game_food/food_game.tscn"),
	preload("res://game_unpacking/unpacking_game.tscn"),
	preload("res://game_makeup/makeup_game.tscn"),
	preload("res://victory/victory.tscn"),
	preload("res://credits/credits.tscn"),
]


func _process(delta):
	if not _timed_level:
		return

	if remaining_time <= delta:
		remaining_time = 0
		show_boring.emit()
		finished_level(false)
		_timeout_callback.call()
		return

	remaining_time -= delta


func start():
	_regular_flow = true
	_current = 0
	_timed_level = false
	get_tree().change_scene_to_packed(_levels[_current])


func finished_level(success: bool, should_sleep = true):
	_timed_level = false
	if success:
		Audio.play_neutral_sound()
		Reactions.win()
	else:
		Audio.play_sad_sound()
		Reactions.lose()

	if should_sleep:
		await get_tree().create_timer(1.0, false).timeout

	if not _regular_flow:
		get_tree().reload_current_scene()
		return

	if success:
		_current = (_current + 1) % len(_levels)
	else:
		_current = 0

	get_tree().change_scene_to_packed(_levels[_current])


func start_timer(total_time: float, timeout_callback: Callable):
	remaining_time = total_time
	_timed_level = true
	_timeout_callback = timeout_callback


func stop_timer():
	_timed_level = false


func display_message(message: String):
	var label = get_tree().get_first_node_in_group("message")
	if label:
		label.text = message
