extends Node


signal on_play_sad_sound()
signal on_play_neutral_sound()
signal on_play_any_sound()


var player: AudioStreamPlayer
@onready var _bus := AudioServer.get_bus_index("Master")


func _ready():
	player = AudioStreamPlayer.new()
	add_child(player)


func play_sad_sound():
	on_play_sad_sound.emit(player)


func play_neutral_sound():
	on_play_neutral_sound.emit(player)


func play_any_sound():
	on_play_any_sound.emit(player)


func set_mute(value: bool):
	AudioServer.set_bus_mute(_bus, value)


func is_mute():
	return AudioServer.is_bus_mute(_bus)


func set_volume(value: float):
	AudioServer.set_bus_volume_db(_bus, linear_to_db(value))


func get_volume() -> float:
	return db_to_linear(AudioServer.get_bus_volume_db(_bus))
