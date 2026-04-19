class_name Power extends Node

@export var power: int = 100:
	get: return power
@export var drainage: int = 1;
const max_power = 100
var sent = false
var charging = false
signal depleted
signal shutdown

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if power <= 15 and !sent:
		depleted.emit()
		sent = true
	if power == 0:
		shutdown.emit();
	
	
func drain_power(amount: int):
	power -= amount


func _on_timer_timeout() -> void:
	if !charging:
		power -= 1


func _on_charger_timeout() -> void:
	if power < max_power and charging:
		print_debug("charging")
		power+=1

func reset():
	power = max_power
	sent = false;
	charging = false;
