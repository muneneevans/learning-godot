extends RayCast3D
class_name RayCastWheel

@export var spring_strength := 100.0
@export var spring_damping :=2 
@export var rest_distance := 0.5
@export var over_extend = 0.0
@export var wheel_radius := 0.4
@export var is_motor := false


@onready var wheel: Node3D = get_node('wheel')

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
