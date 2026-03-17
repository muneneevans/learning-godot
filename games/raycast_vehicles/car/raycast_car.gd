extends RigidBody3D


@export var wheels: Array[RayCast3D]
@export var spring_strength := 100.0
@export var spring_damping := 2
@export var rest_distance := 0.5


func _physics_process(delta: float) -> void:
	for wheel in wheels:
		_do_single_wheel_suspension(wheel) 

func _do_single_wheel_suspension(suspension_ray: RayCast3D) -> void:
	if suspension_ray.is_colliding():
		var contact := suspension_ray.get_collision_point()
		var spring_up_dir := suspension_ray.global_transform.basis.y
		var spring_len := suspension_ray.global_position.distance_to(contact)
		var offset := rest_distance - spring_len

		var spring_force := spring_strength * offset
		var force_vector := spring_force * spring_up_dir

		var force_position_offset := contact - global_position
		apply_force(force_vector, force_position_offset)
	
