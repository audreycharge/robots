extends BaseScene

@onready var body = $Body
@onready var timer = $Timer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_timer_timeout() -> void:
	print_debug("done")
	get_tree().call_deferred('change_scene_to_file', "res://games/activate.tscn")


func _on_body_done() -> void:
	#print_debug("done")
	timer.start()
	pass # Replace with function body.
