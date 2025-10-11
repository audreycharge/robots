class_name Player extends CharacterBody2D


const SPEED = 300.0
var speed = 1.0
const JUMP_VELOCITY = -400.0
var dialoging = false;

#@export var inventory: Inventory
@onready var _animated_sprite = $AnimatedSprite2D


func _physics_process(delta: float) -> void:
	# Add the gravity.
	#if not is_on_floor():
		#velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	#var direction := Input.get_axis("ui_left", "ui_right")
	#
	#if direction:
		#velocity.x = direction * SPEED
	#else:
		#velocity.x = move_toward(velocity.x, 0, SPEED)
		
	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED * speed
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED*speed)

	var directionY := Input.get_axis("up", "down")
	if directionY:
		velocity.y = directionY * SPEED*speed
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED*speed)

	move_and_slide()
	#handleCollision()
	#updateAnimation()
	


func handleCollision():
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i);
		var collider = collision.get_collider();
		print(collider.name)


func _on_area_2d_area_entered(area: Area2D) -> void:
	print("talking")
	pass # Replace with function body.

func updateAnimation():
	var currSprite = _animated_sprite.animation;
	var spriteString = currSprite;
	var string1
	var string2
	
	#if !alive:
		#_animated_sprite.play("die")
		#return
	
	if currSprite.contains("left"):
		string2 = "left"
	else:
		string2 = "right"
	if velocity == Vector2(0,0):
		string1 = "idle"
	else:
		string1 = "walk"
	if velocity.x > 0 :
		string2 = "right"
	elif velocity.x < 0:
		string2 = "left"
	spriteString = string1 + "_" + string2
	_animated_sprite.play(spriteString)
	
