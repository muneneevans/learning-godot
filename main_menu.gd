
#https://www.youtube.com/watch?v=29jCe-mjyKQ
extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_kenney_city_pressed() -> void:
	get_tree().change_scene_to_file("res://examples/kenney_city/kenney_city.tscn")


func _on_raycast_city_pressed() -> void:
	get_tree().change_scene_to_file("res://examples/raycast_vehicles/game.tscn")


func _on_quit_pressed() -> void:
	get_tree().quit()


func _on_composition_pressed() -> void:
	get_tree().change_scene_to_file("res://examples/composition/composition.tscn")


func _on_vehicle_body_node_v_2_pressed() -> void:
	get_tree().change_scene_to_file('res://examples/vehicle_body_node/track.tscn')


func _on_polygon_city_pressed() -> void:
	get_tree().change_scene_to_file("res://examples/polygon_city/metropolis.tscn")


func _on_third_person_controller_pressed() -> void:
	get_tree().change_scene_to_file("res://examples/third_person_controller/main.tscn")


func _on_dashoe_car_library_pressed() -> void:
	get_tree().change_scene_to_file("res://examples/dashoe_car/main.tscn")


func _on_navigation_pressed() -> void:
	get_tree().change_scene_to_file("res://examples/navigation/main.tscn")
