extends Node2D


@export var show_viewer_count: bool = true
@export var show_chat: bool = true


func _ready():
	%ViewersContainer.visible = show_viewer_count
	%ChatContainer.visible = show_chat


func _process(delta):
	%Viewers.text = "%.0f" % (Level.remaining_time * 100)
