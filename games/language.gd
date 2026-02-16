extends Node2D

@onready var sine = $keyboard/sine
@onready var cos = $keyboard/cos
@onready var tan = $keyboard/tan
@onready var bru = $keyboard/bru
@onready var gea = $keyboard/gea
@onready var delete = $keyboard/delete
@onready var code = $Code

var array = []
var correct_array = []
@onready var convo_partner: CharacterBody2D



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#check who partner is
	# if partner is then get the new array from list
	pass # Replace with function body.

func update_code():
	var result = "";
	for i in array:
		result = result + i;
	var n = 6 - array.size()
	for i in n:
		result = result + " _"
	code.text = result
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_delete_pressed() -> void:
	array.pop_back()
	update_code()
	pass # Replace with function body.


func _on_gea_pressed() -> void:
	if array.size() < 6:
		array.append("&");
		update_code()
	
	pass # Replace with function body.


func _on_bru_pressed() -> void:
	if array.size() < 6:
		array.append("^");
		update_code()
	pass # Replace with function body.


func _on_tan_pressed() -> void:
	if array.size() < 6:
		array.append("%");
		update_code()
	pass # Replace with function body.


func _on_cos_pressed() -> void:
	if array.size() < 6:
		array.append("$");
		update_code()
	pass # Replace with function body.


func _on_sine_pressed() -> void:
	if array.size() < 6:
		array.append("#");
		update_code()
	pass # Replace with function body.
