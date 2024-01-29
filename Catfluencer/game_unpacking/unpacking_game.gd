extends Node2D


var _package_count: int = 0


func _ready():
	Level.start_timer(8.0, disable_packages)
	var packages = get_tree().get_nodes_in_group("package")
	_package_count = len(packages)
	for package in packages:
		package.destroyed_content.connect(_on_package_destroyed_content)
		package.finished_package.connect(_on_package_finished_package)


func _on_package_destroyed_content(package):
	$Damaged.visible = true
	Level.finished_level(false)
	disable_packages()


func _on_package_finished_package(package):
	_package_count -= 1
	if _package_count <= 0:
		$Success.visible = true
		Level.finished_level(true)
		disable_packages()
	else:
		Reactions.show_emotion(Reactions.Emotion.Shook, 1.0)
		Audio.play_neutral_sound()


func disable_packages():
	for package in get_tree().get_nodes_in_group("package"):
		package.disable()
