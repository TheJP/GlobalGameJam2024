extends Node2D


@export var show_viewer_count: bool = true
@export var show_chat: bool = true
@export var show_webcam: bool = true
@export var show_controls: bool = true
@export var neutral_sounds: Array[AudioStream] = []
@export var sad_sounds: Array[AudioStream] = []


var emotion_textures = {
	Reactions.Emotion.Cry: preload("res://common/reaction_cry.png"),
	Reactions.Emotion.Glasses: preload("res://common/reaction_glasses.png"),
	Reactions.Emotion.Grumpy: preload("res://common/reaction_grumpy.png"),
	Reactions.Emotion.Huh: preload("res://common/reaction_huh.png"),
	Reactions.Emotion.Neutral: preload("res://common/reaction_neutral.png"),
	Reactions.Emotion.Polite: preload("res://common/reaction_polite.png"),
	Reactions.Emotion.Shook: preload("res://common/reaction_shook.png"),
	Reactions.Emotion.Tongue: preload("res://common/reaction_tongue.png"),
}


func _ready():
	%ViewersContainer.visible = show_viewer_count
	%ChatContainer.visible = show_chat
	%Offline.visible = not show_webcam
	%OnlineBackground.visible = show_webcam
	%Emotion.visible = show_webcam
	%Mic.visible = show_webcam
	%ControlsContainer.visible = show_controls
	%Volume.value = Audio.get_volume()
	%SpeakerButton.visible = not Audio.is_mute()
	%MuteButton.visible = Audio.is_mute()
	Level.show_boring.connect(func(): $Boring.visible = true)
	Audio.on_play_neutral_sound.connect(play_neutral_sound)
	Audio.on_play_sad_sound.connect(play_sad_sound)


func _process(delta):
	%Viewers.text = "%.0f" % (Level.remaining_time * 100)
	%Emotion.texture = emotion_textures[Reactions.current]


func _on_play_button_pressed():
	unpause()


func _on_pause_button_pressed():
	pause()


func _on_resume_button_pressed():
	unpause()


func _on_close_button_pressed():
	unpause()

func _on_restart_button_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://main/main.tscn")


func _on_quit_button_pressed():
	get_tree().quit()


func pause():
	get_tree().paused = true
	%PlayButton.visible = true
	%PauseButton.visible = false
	%PauseMenu.visible = true


func unpause():
	get_tree().paused = false
	%PlayButton.visible = false
	%PauseButton.visible = true
	%PauseMenu.visible = false


func play_neutral_sound(player: AudioStreamPlayer):
	player.stream = neutral_sounds[randi() % len(neutral_sounds)]
	player.play()


func play_sad_sound(player: AudioStreamPlayer):
	player.stream = sad_sounds[randi() % len(sad_sounds)]
	player.play()


func _on_speaker_button_pressed():
	Audio.set_mute(true)
	%SpeakerButton.visible = false
	%MuteButton.visible = true


func _on_muted_button_pressed():
	Audio.set_mute(false)
	%SpeakerButton.visible = true
	%MuteButton.visible = false


func _on_volume_value_changed(value):
	Audio.set_volume(value)
