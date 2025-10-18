class_name Nut extends StaticBody2D



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	handleCollision()
	pass

func handleCollision():
	var test = find_child("Area2D")
	pass
