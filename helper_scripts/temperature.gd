class_name Temperature extends Node
@export var temp: int = 36:
	get: return temp
var max_temp: int = 60
var cooldown = false;


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if temp == max_temp:
		print("shut down")
	elif abs(max_temp - temp) < 15:
		print("overheating imminent")
	if temp < 30:
		cooldown = false
	

func _on_cooldown_timeout() -> void:
	if cooldown:
		temp -= 1;
	pass # Replace with function body.
	
func init_cooldown():
	cooldown = true;
