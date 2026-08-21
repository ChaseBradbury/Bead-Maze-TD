extends Effect
class_name DamageEffect

@export var initial_damage: float
@export var damage_per_rep: float

func handle_initial_effect(bead_controller: BeadController):
	bead_controller.damage(initial_damage)

func handle_ongoing_effect(bead_controller: BeadController):
	pass

func handle_repetition_effect(bead_controller: BeadController):
	bead_controller.damage(damage_per_rep)

func handle_free(bead_controller: BeadController):
	pass
