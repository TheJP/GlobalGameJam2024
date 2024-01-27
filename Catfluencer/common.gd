extends Node2D


@export var show_viewer_count: bool = true


func _ready():
	%ViewersContainer.visible = show_viewer_count


func _process(delta):
	%Viewers.text = "%.0f" % (Level.remaining_time * 100)
