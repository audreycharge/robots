extends Node2D

var parts = [false, false, false, false, false]
signal done;
var active = false;


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
			
	pass
	


func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed("click"):
		print_debug("clcikajf")
		parts[0] = true;
		$Head.texture = load("res://assets/calibration/head_calib.png")


func _on_torso_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed("click") and parts[0]:
		parts[1] = true;
		$"../Torso".texture = load("res://assets/calibration/torso_calib.png")


func _on_arm_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed("click") and parts[1]:
		parts[2] = true;
		$"../Arm".texture = load("res://assets/calibration/arm_calib.png")
		$"../Arm2".texture = load("res://assets/calibration/arm_calib.png")


func _on_leg_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed("click") and parts[2]:
		parts[3] = true;
		$"../Leg".texture = load("res://assets/calibration/leg_calib.png")
		$"../Leg2".texture = load("res://assets/calibration/leg_calib.png")


func _on_foot_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed("click") and parts[3]:
		parts[4] = true;
		done.emit()
		$"../Foot".texture = load("res://assets/calibration/foot_calib.png")
		$"../Foot2".texture = load("res://assets/calibration/foot_calib.png")
