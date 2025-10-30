extends Control

var temperature
var power
@onready var parent: CharacterBody2D

@onready var network_button = $HBoxContainer/network


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	network_button.button_down.connect(on_button_down)
	power = scene_manager.power
	temperature = scene_manager.temp
	#print_debug(scene_manager.power.power)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#var power_amount = power.
	$Power.text = str("Power: ", power.power)
	if power.power < 98:
		#$Power.remove_theme_color_override()
		$Power.add_theme_color_override("default_color", Color(1,0,0,1))
	$Temperature.text = str("Temperature: ", temperature.temp)
	pass

func on_button_down() -> void:
	print("networj")
