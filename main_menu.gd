
#https://www.youtube.com/watch?v=29jCe-mjyKQ
extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_kenney_city_pressed() -> void:
	get_tree().change_scene_to_file("res://games/kenney_city/kenney_city.tscn")


func _on_raycast_city_pressed() -> void:
	get_tree().change_scene_to_file("res://games/raycast_vehicles/game.tscn")


func _on_quit_pressed() -> void:
	get_tree().quit()


func _on_composition_pressed() -> void:
	get_tree().change_scene_to_file("res://games/composition/composition.tscn")


func _on_vehicle_body_node_v_2_pressed() -> void:
	get_tree().change_scene_to_file('res://games/vehicle_body_node/track.tscn')


func _on_polygon_city_pressed() -> void:
	get_tree().change_scene_to_file("res://games/polygon_city/metropolis.tscn")


func _on_third_person_controller_pressed() -> void:
	get_tree().change_scene_to_file("res://games/third_person_controller/main.tscn")
