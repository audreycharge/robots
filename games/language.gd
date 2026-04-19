extends Control

@onready var square = $input/keyboard/square
@onready var circle = $input/keyboard/circle
@onready var up = $input/keyboard/up
@onready var down = $input/keyboard/down
@onready var stick = $input/keyboard/stick
@onready var diamond = $input/keyboard/diamond
@onready var delete = $input/check/delete
@onready var submit = $input/check/submit
@onready var code = $Code
@onready var response = $response

var code_path = "res://assets/ui/codes/";

var array = []
signal submit_code;



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#check who partner is
	# if partner is then get the new array from list
	pass # Replace with function body.

func update_code():
	var result = "";
	var count = 1;
	for i in array:
		result = result + i;
		response.get_node(str(count)).texture = load(str(code_path, i, ".png"))
		count+=1;
	var n = 5 - array.size()
	for i in n:
		result = result + " _"
		response.get_node(str(count)).texture = preload("res://assets/ui/codes/blank.png")
		count+=1;
	code.text = result
	if array.size() < 5:
		submit.disabled = true;
	else:
		submit.disabled = false;
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_delete_pressed() -> void:
	array.pop_back()
	update_code()
	pass # Replace with function body.


func _on_stick_pressed() -> void:
	if array.size() < 5:
		array.append("stick");
		update_code()
	
	pass # Replace with function body.


func _on_down_pressed() -> void:
	if array.size() < 5:
		array.append("down");
		update_code()
	pass # Replace with function body.


func _on_up_pressed() -> void:
	if array.size() < 5:
		array.append("up");
		update_code()
	pass # Replace with function body.


func _on_circle_pressed() -> void:
	if array.size() < 5:
		array.append("circle");
		update_code()
	pass # Replace with function body.


func _on_square_pressed() -> void:
	if array.size() < 5:
		array.append("square");
		update_code()
	pass # Replace with function body.


func _on_submit_pressed() -> void:
	submit_code.emit(array);
	array = [];
	update_code();
	pass # Replace with function body.


func _on_diamond_pressed() -> void:
	if array.size() < 5:
		array.append("diamond");
		update_code()
