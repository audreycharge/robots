extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Dialogic.start("initialize", "finish")
	Dialogic.timeline_ended.connect(on_end)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func on_end():
		get_tree().call_deferred('change_scene_to_file', "res://locations/start_room.tscn")


#func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	##print_debug("go to floor 1")
	#Dialogic.end_timeline()
	#get_tree().call_deferred('change_scene_to_file', "res://locations/start_room.tscn")
	#pass # Replace with function body.
