extends Node2D


func _on_button_pressed():
	get_tree().change_scene_to_file("res://main/main.tscn")


func _on_jammers_button_pressed():
	Audio.play_any_sound()
