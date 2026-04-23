extends BaseScene

@onready var return_markers = $back_home_markers

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#print_debug("room2")
	super()
	if scene_manager.you_break:
		player.dialoging = scene_manager.get_score()
		player.state_machine = "talking"
		Dialogic.start("back_home", player.dialoging)
		$Siren.global_position = $back_home_markers/Siren.global_position
		$Cable.global_position = $back_home_markers/Cable.global_position
		$Diode.global_position = $back_home_markers/Diode.global_position
	Dialogic.signal_event.connect(on_ended)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func on_ended(arg: String):
	if arg == "final":
		scene_manager.go_to_ui(self, "ending");
