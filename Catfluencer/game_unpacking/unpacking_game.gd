extends Node2D

var _package_count: int = 0


func _ready():
	Level.start_timer(6.0, disable_packages)
	var packages = get_tree().get_nodes_in_group("package")
	_package_count = len(packages)
	for package in packages:
		package.package_layers = randi_range(1, 4)
		package.destroyed_content.connect(_on_package_destroyed_content)
		package.finished_package.connect(_on_package_finished_package)


func _on_package_destroyed_content(package):
	Level.display_message("Gadgets\nDamaged! D:")
	Level.finished_level(false)
	disable_packages()


func _on_package_finished_package(package):
	_package_count -= 1
	if _package_count <= 0:
		Level.display_message("Yay :3")
		Level.finished_level(true)
		disable_packages()


func disable_packages():
	for package in get_tree().get_nodes_in_group("package"):
		package.disable()