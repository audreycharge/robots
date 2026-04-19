extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0
const talk = true;

func _ready() -> void:
	Dialogic.signal_event.connect(_on_dialogic_signal)

func _physics_process(delta: float) -> void:
	#
	move_and_slide()

func climb_wall():
	#insert animation to climb wall
	pass

func walk_to_scrap_pile():
	pass
	
func _on_dialogic_signal(argument:String):
	if argument == "calibrate_magnet":
		walk_to_scrap_pile()
		#print("Something was activated!")
	elif argument == "calibrate":
		#print_debug("calibrating time")
		Dialogic.start("calibration");
	elif argument == "siren_wall":
		climb_wall()
