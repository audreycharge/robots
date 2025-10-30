class_name SceneTrigger extends Area2D

@export var connected_scene: String #name of scene to change to
var scene_folder = "res;//scenes/locations/"

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		print('tree hit');
		#print_debug(Player.position)
		#print_debug(position)
		
		if connected_scene == "sorting":
			#print((body.position - position).length())
			if (body.position - position).length() < Vector2(90,90).length():
				#print_debug("im going to sort stuff")
				scene_manager.go_to_minigame(get_owner(), connected_scene)
		else:
			scene_manager.change_scene(get_owner(), connected_scene)
