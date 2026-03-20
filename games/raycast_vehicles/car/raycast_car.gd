extends RigidBody3D


@export var wheels: Array[RayCastWheel]
@export var acceleration := 6
@export var deceleration := 200
@export var max_speed := 20
@export var acceleration_curve: Curve

var motor_input := 0


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("accelerate"):
		motor_input = 1
	elif event.is_action_released("accelerate"):
		motor_input = 0
		
	if event.is_action_pressed("decelerate"):
		motor_input = -1
	elif event.is_action_released("decelerate"):
		motor_input = 0
		
	

func _physics_process(delta: float) -> void:
	var grounded := false
	for wheel in wheels:
		if wheel.is_colliding():
			grounded = true

		wheel.force_raycast_update()
		_do_single_wheel_acceleration(wheel)
		_do_single_wheel_suspension(wheel)

	if grounded:
		center_of_mass = Vector3.ZERO
	else:
		center_of_mass_mode = RigidBody3D.CENTER_OF_MASS_MODE_CUSTOM
		center_of_mass = Vector3.DOWN * 0.5

func _get_point_velocity(point: Vector3) -> Vector3:
	return linear_velocity + angular_velocity.cross(point - global_position)

func _do_single_wheel_acceleration(ray: RayCastWheel) -> void:
	var forward_direction := -ray.global_basis.z
	var velocity := forward_direction.dot(linear_velocity)
	
	# Wheel surface 2 * PI * r = distance traveled in one rotation
	ray.wheel.rotate_x(-velocity * get_process_delta_time() * 2 * PI * ray.wheel_radius)
	
	if ray.is_colliding() :
		var contact := ray.get_collision_point()
		var force_position := contact - global_position
	
		if ray.is_motor and motor_input:
			var speed_ratio := velocity / max_speed
			var acceleration_ratio := acceleration_curve.sample_baked(speed_ratio) 
			var force_vector := forward_direction * acceleration * motor_input * acceleration_ratio

			apply_force(force_vector , force_position)
			# DebugDraw3D.draw_arrow_ray(contact, force_vector/mass,2.5, Color.RED)
		
		
		elif abs(velocity) > 0.1 and not motor_input:
			var drag_force_vector = global_basis.z  * deceleration * signf(velocity)
			apply_force(drag_force_vector, force_position)
			# DebugDraw3D.draw_arrow_ray(contact, drag_force_vector/mass,2.5, Color.PURPLE) 		

func _do_single_wheel_suspension(ray: RayCastWheel) -> void:
	if ray.is_colliding():

		ray.target_position.y = -(ray.rest_distance + ray.wheel_radius + ray.over_extend)

		var contact := ray.get_collision_point()
		var spring_up_dir := ray.global_transform.basis.y
		var spring_len := ray.global_position.distance_to(contact) - ray.wheel_radius
		var offset := ray.rest_distance - spring_len

		ray.wheel.position.y = -spring_len

		var spring_force := ray.spring_strength * offset


		var world_vel := _get_point_velocity(contact)
		var relative_vel := spring_up_dir.dot(world_vel)
		var spring_damping_force := ray.spring_damping * relative_vel


		var force_vector := (spring_force - spring_damping_force) * ray.get_collision_normal()

		contact = ray.wheel.global_position
		var force_position_offset := contact - global_position
		apply_force(force_vector, force_position_offset)

		# DebugDraw3D.draw_arrow_ray(contact, force_vector/mass, 2.5)
		# DebugDraw3D.draw_sphere(ray.get_collision_point(), 0.25, Color.YELLOW)
	
