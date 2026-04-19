class_name SceneManager extends Node

var player: Player
var last_scene_name: String

var scene_dir_path = "res://locations/"
var game_dir_path = "res://games/"
var menu_path = "res://UI/main_menu.tscn"
var ling_json = "res://games/ling.json"
var player_json = "res://helper_scripts/player.json"

var response_codes: Dictionary = {}
var player_info: Dictionary = {}
var sort_complete = false;
var shift = 1;
var break_talks = 0;
var you_break = false


@onready var temp
@onready var power
#@onready var p_score = 0;
#@onready var n_score = 0;
#@onready var location


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	temp = preload("res://helper_scripts/temperature.tscn").instantiate()
	power = preload("res://helper_scripts/power.tscn").instantiate()
	add_child(temp)
	add_child(power)
	#power.depleted.connect(on_low_battery)
	response_codes = load_json_file(ling_json)
	player_info = load_json_file(player_json)
	#load_player_file()
	#print_debug(response_codes.get("siren").array)
	pass # Replace with function body.

func update_player_file():
	var json_string = JSON.stringify(player_info, "\t")
	var file = FileAccess.open(player_json, FileAccess.WRITE)
	file.store_string(json_string);
	
func load_player_file():
	var file = FileAccess.open(player_json, FileAccess.READ)
	assert(file.file_exists(player_json), "File path does not exist")
	
	#read contents of the file as text
	var json = file.get_as_text()
	var json_object = JSON.new()
		
	#parse the json text
	json_object.parse(json)
	player_info = json_object.data
	
	return player_info;
	

func load_json_file(json_file):
	#open file for reading
	var file = FileAccess.open(json_file, FileAccess.READ)
	#check if file exists
	assert(file.file_exists(json_file), "File path does not exist")
	
	#read contents of the file as text
	var json = file.get_as_text()
	var json_object = JSON.new()
		
	#parse the json text
	json_object.parse(json)
	var dict = json_object.data
	
	return dict;

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func compare_codes(submitted, partner):
	var correct = 0
	var partner_array = response_codes[partner].array
	response_codes[partner].interaction_points += 1;
	for i in 5:
		if submitted[i] == partner_array[i]:
			correct+=1
	if correct < 3:
		increment_n(1)
		return "wrong";
	elif correct < 4:
		increment_n(1)
		increment_p(1)
		return "neutral";
	else:
		increment_p(1)
		return "right";

func go_to_minigame(from, to_scene_name: String) -> void:
	save_player(from)
	
	var full_path = game_dir_path + to_scene_name + ".tscn"
	print(full_path)
	from.get_tree().call_deferred('change_scene_to_file', full_path)

func change_scene(from, to_scene_name: String) -> void:
	save_player(from)
	#location = to_scene_name
	
	var full_path = scene_dir_path + to_scene_name + ".tscn"
	print_debug(full_path)
	from.get_tree().call_deferred('change_scene_to_file', full_path)
	update_shutdown_count();
	
func return_to_scene(from, to_scene_name: String) -> void:
	#location = to_scene_name
	var full_path
	if !to_scene_name.contains("tscn"):
		full_path = scene_dir_path + to_scene_name + ".tscn"
	else:
		full_path = to_scene_name
	from.get_tree().call_deferred('change_scene_to_file', full_path)
	player.state_machine = "moving"
	player.get_node("Camera2D/HUD/glitch").visible = false;

func save_player(from):
	last_scene_name = from.name
	if from.player:
		player = from.player
		player.global_position -= Vector2(20, 0)
		print_debug(player.global_position)
		player.get_parent().remove_child(player)
	
func increment_p(n):
	player_info["p_score"] += n
	
func increment_n(n):
	player_info["n_score"] += n
	
func get_score():
	var p_score = player_info["p_score"]
	var n_score = player_info["n_score"]
	if p_score !=0 or n_score !=0:
		return p_score/n_score;
	elif p_score == 0 and n_score == 0:
		return "you can't avoid your way into a better life";
	
#func on_low_battery():
	#player.hu
	#print_debug("Low Battrey")

func reset_levels():
	power.reset()
	temp.reset()
	
func update_shutdown_count():
	player_info["shutdowns"] += 1
	var test = player_info["shutdowns"]
	print_debug(str("shutdowns: ", test));
	
func return_to_menu(from):
	print_debug(from)
	save_player(from)
	from.get_tree().call_deferred('change_scene_to_file', menu_path)
