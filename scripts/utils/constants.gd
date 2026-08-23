extends Node
class_name Constants

static var TOWER_MODEL_SCENES: Array = [
	load("res://scenes/towers/default_tower_model.tscn"),
	load("res://scenes/towers/tower_1_model.tscn")
]

enum Targeting {
	CLOSEST,
	FIRST,
	LAST
}
