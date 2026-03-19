class_name SceneManager extends Node

var player: Player
var last_scene_name: String

var scene_dir_path = "res://locations/"
var game_dir_path = "res://games/"
var ling_json = "res://games/ling.json"
var response_codes: Dictionary = {}


@onready var temp
@onready var power
@onready var p_score = 0;
@onready var n_score = 0;
@onready var location


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	temp = preload("res://helper_scripts/temperature.tscn").instantiate()
	power = preload("res://helper_scripts/power.tscn").instantiate()
	add_child(temp)
	add_child(power)
	power.depleted.connect(on_low_battery)
	load_json_file()
	#print_debug(response_codes.get("siren").array)
	
	
	
	pass # Replace with function body.

func load_json_file():
	#open file for reading
	var file = FileAccess.open(ling_json, FileAccess.READ)
	#check if file exists
	assert(file.file_exists(ling_json), "File path does not exist")
	
	#read contents of the file as text
	var json = file.get_as_text()
	var json_object = JSON.new()
		
	#parse the json text
	json_object.parse(json)
	response_codes = json_object.data
	
	return response_codes;

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	pass
	
func compare_codes(submitted, partner):
	var correct = 0
	var partner_array = response_codes.get(partner).array
	for i in 5:
		if submitted[i] == partner_array[i]:
			correct+=1
	return correct;
func go_to_minigame(from, to_scene_name: String) -> void:
	save_player(from)
	
	var full_path = game_dir_path + to_scene_name + ".tscn"
	print(full_path)
	from.get_tree().call_deferred('change_scene_to_file', full_path)
	
	

func change_scene(from, to_scene_name: String) -> void:
	save_player(from)
	location = to_scene_name
	
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
