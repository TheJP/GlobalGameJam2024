extends Node


signal on_play_sad_sound()
signal on_play_neutral_sound()


var player: AudioStreamPlayer


func _ready():
	player = AudioStreamPlayer.new()
	add_child(player)


func play_sad_sound():
	on_play_sad_sound.emit(player)
	
	
func play_neutral_sound():
	on_play_neutral_sound.emit(player)
