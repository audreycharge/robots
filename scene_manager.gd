class_name SceneManager extends Node

var player: Player
var last_scene_name: String

var scene_dir_path = "res://locations/"
var game_dir_path = "res://games/"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func go_to_minigame(from, to_scene_name: String) -> void:
	last_scene_name = from.name
	player = from.player
	player.get_parent().remove_child(player)
	
	var full_path = game_dir_path + to_scene_name + ".tscn"
	print(full_path)
	from.get_tree().call_deferred('change_scene_to_file', full_path)
	
	

func change_scene(from, to_scene_name: String) -> void:
	last_scene_name = from.name
	player = from.player
	player.get_parent().remove_child(player)
	
	var full_path = scene_dir_path + to_scene_name + ".tscn"
	print(full_path)
	from.get_tree().call_deferred('change_scene_to_file', full_path)
