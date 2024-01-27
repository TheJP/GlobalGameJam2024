extends Node


var _regular_flow = false
var _current = 0
const _levels = [
	preload("res://01_sofa_game/sofa_game.tscn"),
	preload("res://victory.tscn"),
	preload("res://credits.tscn"),
]


func start():
	_regular_flow = true
	_current = 0
	get_tree().change_scene_to_packed(_levels[_current])


func finished_level(success: bool, should_sleep = true):
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
