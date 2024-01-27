extends Node


var _current = 0
const _levels = [
	preload("res://01_sofa_game/sofa_game.tscn")
]

func finished_level(success: bool):
	await get_tree().create_timer(1.0, false).timeout

	if success:
		_current = (_current + 1) % len(_levels)
	else:
		_current = 0

	get_tree().change_scene_to_packed(_levels[_current])
