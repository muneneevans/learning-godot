extends Node3D

@onready var navigation_agent: NavigationAgent3D = $NavigationAgent3D
@onready var npc_car_controller: NPCVehicleController = $npc_vehicle_controller
@onready var vehicle: Vehicle = $npc_vehicle_controller/sedan

func _ready() -> void:
	start_navigation()

func _physics_process(_delta: float):
	if navigation_agent.is_navigation_finished():
		start_navigation()
	
	var next_position := navigation_agent.get_next_path_position()
	var direction_to_target := (next_position - global_position).normalized()

	var car_forward = -global_transform.basis.z.normalized()

	var angle = car_forward.angle_to(direction_to_target)
	var cross = car_forward.cross(direction_to_target).y
	var steering_input = clamp(angle * vehicle.steering_speed * sign(cross), -1, 1)
	
	var _distance_to_target = vehicle.global_position.distance_to(next_position)
	var speed = vehicle.linear_velocity.length()

	var throttle_input = 0
	var brake_input = 0

	if abs(angle) < 30:
		throttle_input = clamp((20 - speed) / 20, 0, 1)
	else:
		brake_input = 0.5

	npc_car_controller.move(throttle_input, brake_input, 0, steering_input, false)
	
	# Debug visualization
	_debug_draw(next_position, direction_to_target, angle)

func _debug_draw(next_position: Vector3, direction_to_target: Vector3, angle: float) -> void:
	# Draw line to next path position
	DebugDraw3D.draw_line(global_position, next_position, Color.GREEN)
	
	# Draw car forward direction
	DebugDraw3D.draw_line(global_position, global_position + -global_transform.basis.z * 5, Color.BLUE)
	
	# Draw target direction
	DebugDraw3D.draw_line(global_position, global_position + direction_to_target * 5, Color.RED)
	
	# Draw sphere at target
	DebugDraw3D.draw_sphere(next_position, 0.5, Color.YELLOW)
	
	# Draw angle info
	print("Angle: %.2f | Speed: %.2f" % [rad_to_deg(angle), vehicle.linear_velocity.length()])

func start_navigation() -> void:
	var random_position = global_position
	random_position.x = 31
	random_position.z = -41

	navigation_agent.set_target_position(random_position)

	print("[reachable]:", navigation_agent.is_target_reachable(),
		" [dist]:", navigation_agent.distance_to_target(),
		" [final]:", navigation_agent.get_final_position())
