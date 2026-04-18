class_name InputController
extends Node

var movement_direction: Vector3

func update():
	if Input.is_action_pressed("movement"):
		movement_direction.x = Input.get_action_strength("move_left") - Input.get_action_strength("move_right")
		movement_direction.z = Input.get_action_strength("move_up") - Input.get_action_strength("move_down")

func get_movement_state():
	if Input.is_action_pressed("movement"):
		if is_movement_ongoing():
			if Input.is_action_pressed("sprint"):
				return 'sprint'
			else:
				if Input.is_action_pressed("walk"):
					return 'walk'
				else:
					return 'run'
	else:
		return "stand"
		
		
func is_movement_ongoing() -> bool:
	return abs(movement_direction.x) > 0 or abs(movement_direction.z) > 0
