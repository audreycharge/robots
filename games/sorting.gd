class_name Sorting extends TaskScene


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _input(event):
	if event.is_action_pressed("interact"):
		print_debug("leave the sort")
		scene_manager.change_scene(self, "floor_2")
