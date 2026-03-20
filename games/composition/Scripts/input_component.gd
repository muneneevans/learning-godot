class_name InputComponent extends Node

var move_direction : Vector2 = Vector2.ZERO
var jump_pressed :bool = false


func update() -> void:
	move_direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	jump_pressed = Input.is_action_just_pressed("jump")
	pass
