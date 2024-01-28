extends Node2D


@export var show_viewer_count: bool = true
@export var show_chat: bool = true
@export var show_webcam: bool = true
@export var show_controls: bool = true


var emotion_textures = {
	Reactions.Emotion.Cry: preload("res://common/reaction_cry.png"),
	Reactions.Emotion.Glasses: preload("res://common/reaction_glasses.png"),
	Reactions.Emotion.Grumpy: preload("res://common/reaction_grumpy.png"),
	Reactions.Emotion.Huh: preload("res://common/reaction_huh.png"),
	Reactions.Emotion.Neutral: preload("res://common/reaction_neutral .png"),
	Reactions.Emotion.Polite: preload("res://common/reaction_polite .png"),
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
	Level.show_boring.connect(func(): $Boring.visible = true)


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
