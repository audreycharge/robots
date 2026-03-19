class_name Player extends CharacterBody2D


const SPEED = 300.0
var speed = 1.0
const JUMP_VELOCITY = -400.0
var dialoging = "";
var interactable = false
@onready var language = $Camera2D/Language
#@export var inventory: Inventory
@onready var _animated_sprite = $AnimatedSprite2D

func _ready() -> void:
	#Dialogic.signal.connect(_on_dialogic_signal)
	pass

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
	updateAnimation()
	#get_node("talkbox/CollisionShape2D").get_overlapping_areas()
	


func handleCollision():
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i);
		var collider = collision.get_collider();
		print(collider.name)


func _on_area_2d_area_entered(area: Area2D) -> void:
	print_debug(area.get_parent().name)
	if area.get_parent().is_in_group("robot"):
		get_node("Camera2D/HUD/talk").visible = true
		interactable = true
		dialoging = area.get_parent().name
		
	elif area.is_in_group("snoop"):
		print_debug("you are snooping")
		get_node("Camera2D/HUD/talk").visible = true
		dialoging = "ceiling"
	pass # Replace with function body.

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("interact") and interactable:
		interactable = false
		if dialoging != "":
			print_debug(Dialogic.VAR.response)
			print_debug(get_parent().name)
			Dialogic.start(get_parent().name, dialoging)
	elif event.is_action_pressed("interact"):
		if dialoging == "ceiling":
			Dialogic.start(get_parent().name, dialoging);
		
func get_dialogue(location: String, context: String):
	var layout = Dialogic.start(location, context)

func updateAnimation():
	var currSprite = _animated_sprite.animation;
	var spriteString = currSprite;
	var string1
	var string2
	#print(currSprite)
	
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
	if velocity.x > 0:
		string2 = "right"
	elif velocity.x < 0:
		string2 = "left"
	spriteString = string1 + "_" + string2
	#print(spriteString)
	
	_animated_sprite.play(spriteString)
	

func _on_dialogic_signal(argument: String):
	print_debug("you pass out");
	scene_manager.change_scene(get_owner(), "homeroom")

func _on_talkbox_area_exited(area: Area2D) -> void:
	get_node("Camera2D/HUD/talk").visible = false
	interactable = false
	dialoging = null
	pass # Replace with function body.


func _on_language_submit_code(code) -> void:
	print(code)
	# do some code checking with the convo partner
	var correct = scene_manager.compare_codes(code, "siren");
	print_debug(str("you got ", correct, " correct"))
	pass # Replace with function body.
