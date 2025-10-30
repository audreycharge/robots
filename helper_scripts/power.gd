class_name Power extends Node

@export var power: int = 100:
	get: return power
@export var drainage: int = 1;
const max_power = 100

signal low_battery

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if power < 10:
		low_battery.emit()
	
	
func drain_power(amount: int):
	power -= amount

func charge():
	if power < max_power:
		power+=1


func _on_timer_timeout() -> void:
	power -= 1
	pass # Replace with function body.
