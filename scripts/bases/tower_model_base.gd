extends Node3D
class_name TowerModelBase

var target: Node3D
var tower: Tower

func set_target(new_target: Node3D):
	target = new_target

func set_tower(new_tower: Tower):
	tower = new_tower

func handle_set_target():
	pass

func handle_set_tower():
	pass
