class_name Magnet extends CharacterBody2D

const SPEED = 500
var size = 1;
var og_scale;
var full = false
var ma

func _init() -> void:
	og_scale = scale

func _process(delta):
	var vec = get_viewport().get_mouse_position() - self.position # getting the vector from self to the mouse
	#vec = vec.normalized() * delta * SPEED # normalize it and multiply by time and speed
	position += vec # move by that vector
	scale = og_scale * size
	
func _input(event):
	if event.is_action_pressed("up")  and size < 3:
		size = size + 0.5
	if event.is_action_pressed("down") and size > 1:
		size = size - 0.5
		


func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.is_pressed():
		print("lsjdg")
	pass # Replace with function body.
