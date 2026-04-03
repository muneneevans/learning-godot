extends VehicleBody3D

@export var MAX_STEER = 0.9
@export var ENGINE_POWER = 301
@export var DEBUG_FORCE_SCALE = 4.0
@export var DEBUG_ARROW_SIZE = 1.6
@export var DEBUG_HEIGHT_OFFSET = 0.9


func _physics_process(delta: float) -> void:
	var steer_input := Input.get_axis("move_right", "move_left")
	var throttle_input := Input.get_axis("decelerate", "accelerate")

	steering = move_toward(steering, steer_input * MAX_STEER, delta * 10.0)
	engine_force = throttle_input * ENGINE_POWER

	_draw_debug_vectors(steer_input, throttle_input)


func _draw_debug_vectors(steer_input: float, throttle_input: float) -> void:
	var origin: Vector3 = global_position + Vector3.UP * DEBUG_HEIGHT_OFFSET
	var forward: Vector3 = -global_basis.z
	var force_norm := 0.0
	if ENGINE_POWER != 0.0:
		force_norm = engine_force / ENGINE_POWER

	# Green = forward force, red = reverse force.
	var force_color := Color.LIME_GREEN if force_norm >= 0.0 else Color.INDIAN_RED
	var force_dir: Vector3 = forward * force_norm * DEBUG_FORCE_SCALE
	DebugDraw3D.draw_arrow_ray(origin, force_dir, DEBUG_ARROW_SIZE, force_color)

	var steer_dir := forward.rotated(global_basis.y, steering)
	DebugDraw3D.draw_arrow_ray(origin + Vector3.UP * 0.15, steer_dir * 2.2, 1.0, Color.DEEP_SKY_BLUE)

	DebugDraw2D.set_text("Vehicle/Throttle input", snapped(throttle_input, 0.001))
	DebugDraw2D.set_text("Vehicle/Steer input", snapped(steer_input, 0.001))
	DebugDraw2D.set_text("Vehicle/Engine force", snapped(engine_force, 0.01))
	DebugDraw2D.set_text("Vehicle/Steering", snapped(steering, 0.001))
