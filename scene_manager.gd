class_name SceneManager extends Node

var player: Player
var last_scene_name: String

var scene_dir_path = "res://locations/"
var game_dir_path = "res://games/"

@onready var temp
@onready var power
@onready var p_score = 0;
@onready var n_score = 0;


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	temp = preload("res://helper_scripts/temperature.tscn").instantiate()
	power = preload("res://helper_scripts/power.tscn").instantiate()
	add_child(temp)
	add_child(power)
	
	power.depleted.connect(on_low_battery)
	
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	pass
	
func go_to_minigame(from, to_scene_name: String) -> void:
	save_player(from)
	
	var full_path = game_dir_path + to_scene_name + ".tscn"
	print(full_path)
	from.get_tree().call_deferred('change_scene_to_file', full_path)
	
	

func change_scene(from, to_scene_name: String) -> void:
	save_player(from)
	
	var full_path = scene_dir_path + to_scene_name + ".tscn"
	print_debug(full_path)
	from.get_tree().call_deferred('change_scene_to_file', full_path)

func save_player(from):
	last_scene_name = from.name
	if from.player:
		player = from.player
		player.global_position -= Vector2(20, 0)
		print_debug(player.global_position)
		player.get_parent().remove_child(player)
	
func increment_p(n):
	p_score+= n;
	
func increment_n(n):
	n_score+= n;
	
func get_score():
	return p_score/n_score;
	
func on_low_battery():
	print_debug("Low Battrey")
