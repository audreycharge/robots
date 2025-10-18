class_name Power extends Node

@export var power_level: int = 100
@export var drainage: int = 1;

signal low_battery

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if power_level < 10:
		low_battery.emit()
	pass
	
func drain_power(amount: int):
	power_level -= amount
