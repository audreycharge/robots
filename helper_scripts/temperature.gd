class_name Temperature extends Node
@export var temp: int = 36:
	get: return temp
const MAX_TEMP: int = 60
var cooldown = false;
const DEFAULT = 36

signal overheating;
signal cooled;
signal shutdown;
var sent = false;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if temp == MAX_TEMP:
		print("shut down")
		shutdown.emit()
	elif abs(MAX_TEMP - temp) < 15 and !sent:
		print("overheating imminent")
		overheating.emit()
		sent = true;
	if temp < 36 and cooldown:
		cooldown = false
		cooled.emit()
	
func reset():
	temp = DEFAULT
	cooldown = false
	sent = false

func _on_cooldown_timeout() -> void:
	if cooldown:
		temp -= 1;
	
func init_cooldown():
	cooldown = true;
	$Cooldown.start()
	sent = false


func _on_heatup_timeout() -> void:
	temp += 1;
