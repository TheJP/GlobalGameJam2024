extends Node2D


@export var show_viewer_count: bool = true
@export var show_chat: bool = true
@export var show_webcam: bool = true


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


func _process(delta):
	%Viewers.text = "%.0f" % (Level.remaining_time * 100)
	%Emotion.texture = emotion_textures[Reactions.current]
