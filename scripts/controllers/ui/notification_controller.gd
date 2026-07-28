extends Label
class_name Notification

enum Type {
	MESSAGE,
	CAUTION,
	WARNING
}

@export var notification_time: float = 2
@export var message_color: Color = Color("ffffff")
@export var caution_color: Color = Color("ffd953")
@export var warning_color: Color = Color("ff5838")

var time_elapsed: float = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	time_elapsed = 0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	time_elapsed += delta
	if time_elapsed > notification_time:
		queue_free()

func set_type(type: Type):
	match(type):
		Type.MESSAGE:
			modulate = message_color
		Type.CAUTION:
			modulate = caution_color
		Type.WARNING:
			modulate = warning_color
