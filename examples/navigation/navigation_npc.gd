extends CharacterBody3D

@onready var navigation_agent_3d: NavigationAgent3D = $NavigationAgent3D

func _ready() -> void:
	start_navigation()

func _physics_process(delta: float) -> void:
	if navigation_agent_3d.is_navigation_finished():
		start_navigation()
		
	var destination = navigation_agent_3d.get_next_path_position()
	var direction = (destination - global_position).normalized()

	velocity = direction * 5.0
	move_and_slide()

func start_navigation() -> void:
	var random_position = global_position
	random_position.x = randf_range(-5.0, 5.0)
	random_position.z = randf_range(-5.0, 5.0)

	navigation_agent_3d.set_target_position(random_position)

	print("[reachable]:", navigation_agent_3d.is_target_reachable(),
		" [dist]:", navigation_agent_3d.distance_to_target(),
		" [final]:", navigation_agent_3d.get_final_position())
