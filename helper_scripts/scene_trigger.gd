class_name SceneTrigger extends Area2D

@export var connected_scene: String #name of scene to change to
var scene_folder = "res;//scenes/locations/"

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		print('tree hit');
		
		#scene_manager.change_scene(get_owner(), connected_scene)
	pass # Replace with function body.
