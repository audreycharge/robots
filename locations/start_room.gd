extends BaseScene

@onready var instructions
@onready var load

var lowered = false;
var maxed = false;


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	scene_manager.reset_levels()
	super()
	instructions = player.get_node("Camera2D/HUD/instructions")
	print_debug(instructions.text)
	Dialogic.signal_event.connect(on_dialogic_signal)
	#player.get_node("magnet_range").overpowered.connect(on_overpowered)
	#player.get_node("magnet_range").lower.connect(on_lower)
	player.get_node("magnet_range").magnetizedSignal.connect(on_magged)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if scene_manager.temp.temp > 45 and !maxed:
		Dialogic.start("calibration","overpowered")
		maxed = true;
	pass

func on_dialogic_signal(argument: String):
	if argument == "calibrate_magnet":
		instructions.visible = true;
		instructions.text = "Press F to toggle your magnet. Use mouse scroll (or use C and Z) to change magnetic force. Using magnets will raise your temperature."

#func on_overpowered():
	#if maxed:
		#return;
	#
	#maxed = true;
	

#func on_lower():
	#if lowered:
		#return;
	##Dialogic.clear();
	#Dialogic.start("calibration","lower")
	#lowered = true;

func on_magged():
	if player.get_node("Camera2D/HUD/instructions").visible:
		player.get_node("Camera2D/HUD/instructions").visible = false;
