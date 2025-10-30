extends Control

@onready var start_button = $VBoxContainer/Start
@onready var exit_button = $VBoxContainer/Exit
@onready var controls_button = $VBoxContainer/Controls
@onready var credits_button = $VBoxContainer/Credits
@onready var start_game = "res://locations/floor_1.tscn"


# Called when the node enters the scene tree for the first time.
func _ready():
	start_button.button_down.connect(on_start_pressed)
	exit_button.button_down.connect(on_exit_pressed)
	controls_button.button_down.connect(on_controls_pressed)
	credits_button.button_down.connect(on_credits_pressed)

func on_start_pressed() -> void:
	get_tree().call_deferred('change_scene_to_file', start_game)
	
func on_exit_pressed() -> void:
	get_tree().quit()
	
func on_credits_pressed() -> void:
	print("credits")
	#get_tree().call_deferred('change_scene_to_file', "res://scenes/GUI/credits.tscn")

func on_controls_pressed() -> void:
	print("controls")
	#get_tree().call_deferred('change_scene_to_file', "res://scenes/GUI/instructions.tscn")
