extends Node

enum Scene {
	MAIN_MENU, LEVEL
}


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func change_scene(scene: Scene):
	match scene:
		Scene.MAIN_MENU:
			get_tree().change_scene_to_file("res://scenes/ui/main_menu.tscn")
		Scene.LEVEL:
			get_tree().change_scene_to_file("res://scenes/level.tscn")
