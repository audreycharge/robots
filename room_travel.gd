extends BaseScene

@onready var trak = $Trak_broken

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#print_debug("room2")
	super()
	if scene_manager.you_break and name == "homeroom":
		Dialogic.start("back_home")
	if scene_manager.trak_break and name == "hallway":
		init_hall_2()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func init_hall_2():
	trak.visible = true;
	
