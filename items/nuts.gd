class_name Nut extends CharacterBody2D

@onready var sprite = $Sprite2D
@onready var space = $Area2D
var attracted = false
var sorted = false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var img = randi() % 4 + 1
	sprite.animation = str(img)
	velocity.y = 0;
	velocity.x = -300
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	move_and_slide()
	#velocity.x = -300
	if attracted or sorted:
		velocity = Vector2(0,0)
	else:
		velocity = Vector2(-300, 0)
	handleCollision()
	pass

func return_to_belt():
	attracted = false
	

	


func handleCollision():
	var test = find_child("Area2D")
	sorted = false
	for s in space.get_overlapping_areas():
		#print_debug(s.get_parent().name)
		if s.get_parent().name == "box":
			sorted = true;
	pass
