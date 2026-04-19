class_name Player extends CharacterBody2D


const SPEED = 300.0
var speed = 1.0
var state_machine = "moving"
const JUMP_VELOCITY = -400.0
var dialoging = "";
var interactable = false
@onready var language = $Camera2D/Language
#@export var inventory: Inventory
@onready var _animated_sprite = $AnimatedSprite2D
var last_direction = "right"

signal shutdown

func _ready() -> void:
	Dialogic.signal_event.connect(_on_dialogic_signal)
	Dialogic.timeline_ended.connect(_on_timeline_ended)
	scene_manager.temp.shutdown.connect(on_shutdown)
	scene_manager.power.shutdown.connect(on_shutdown)
	pass

func _physics_process(delta: float) -> void:

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	if state_machine == "moving":

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
	#elif state_machine == "booting":
		#_animated_sprite.play("booting")
		#print_debug("im ded")
	
func _process(delta: float) -> void:
	var interactions = $talkbox.get_overlapping_areas();
	get_node("Camera2D/HUD/talk").visible = false
	#get_node("Camera2D/HUD/sort").visible = false
	dialoging = null
	interactable = false;
	for i in interactions:
		if interactable:
			continue
		if i.get_parent().is_in_group("robot") and i.get_parent().talk:
			get_node("Camera2D/HUD/talk").visible = true
			interactable = true
			dialoging = i.get_parent().name
			get_node("Camera2D/HUD/talk").text = str("E -> Talk to ", dialoging)
			break;
		elif i.is_in_group("robot"):
			get_node("Camera2D/HUD/talk").visible = true
			interactable = true
			dialoging = i.name
			get_node("Camera2D/HUD/talk").text = str("E -> Talk to ", dialoging)
			break;
		elif i.is_in_group("snoop"):
			get_node("Camera2D/HUD/talk").visible = true
			dialoging = "ceiling"
			get_node("Camera2D/HUD/talk").text = "E -> Listen"
		elif i.get_parent().is_in_group("sorting"):
			get_node("Camera2D/HUD/talk").visible = true
			get_node("Camera2D/HUD/talk").text = "E -> Sort"
			dialoging = "sorting"
		elif i.get_parent().is_in_group("item"):
			get_node("Camera2D/HUD/talk").visible = true
			dialoging = i.get_parent()
			get_node("Camera2D/HUD/talk").text = str("E -> ", dialoging.name)
			
	

func handleCollision():
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i);
		var collider = collision.get_collider();
		print(collider.name)

func reset():
	$magnet_range.reset()
	$Camera2D/HUD.reset()
	$AnimationPlayer.stop()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("interact") and interactable:
		state_machine = "talking"
		interactable = false
		if dialoging != "":
			print_debug(Dialogic.VAR.response)
			print_debug(get_parent().name)
			if !Dialogic.VAR.work:
				Dialogic.start(get_parent().name, dialoging)
			else:
				Dialogic.start(get_parent().name, "work")
	elif event.is_action_pressed("interact"):
		if typeof(dialoging) == TYPE_STRING:
			if dialoging == "ceiling":
				state_machine = "talking"
				Dialogic.start(get_parent().name, dialoging);
			elif dialoging == "sorting":
				state_machine = "sorting"
				#print_debug("do your job")
				scene_manager.go_to_minigame(get_parent(), dialoging)
		elif dialoging.is_in_group("item"):
			state_machine = "talking"
			Dialogic.start(get_parent().name, dialoging.name)
		
		
func get_dialogue(location: String, context: String):
	var layout = Dialogic.start(location, context)

func updateAnimation():
	var currSprite = _animated_sprite.animation;
	var spriteString = currSprite;
	if state_machine == "booting":
		spriteString = "walk_right"
	else:
		var string1
		var string2
		#print(currSprite)
		
		#if !alive:
			#_animated_sprite.play("die")
			#return
		if currSprite.contains("left"):
			string2 = "left"
			_animated_sprite.flip_h = true
			last_direction = "left"
		elif currSprite.contains("right"):
			string2 = "right"
			last_direction = "right"
			_animated_sprite.flip_h = false
		else:
			string2 = last_direction
			if string2 == "left":
				_animated_sprite.flip_h = true
			else:
				_animated_sprite.flip_h = false
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
	if (argument == "respond"):
		language.visible = true;
	elif (argument == "overheat"):
		print_debug("you pass out");
		$AnimationPlayer.play("shutdown");

func _on_timeline_ended():
	if !language.visible:
		state_machine = "moving"


func _on_language_submit_code(code) -> void:
	print(code)
	language.visible = false
	# do some code checking with the convo partner
	Dialogic.VAR.response = scene_manager.compare_codes(code, dialoging);
	print_debug(Dialogic.VAR.response)
	#var context_
	Dialogic.start(get_parent().name, str(dialoging,"_response"))
	#Dialogic.start(get_parent().name, "start_again")
	pass # Replace with function body.


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "shutdown":
		if get_parent().name == "start_room":
			scene_manager.change_scene(get_parent(), "homeroom")
			scene_manager.reset_levels()
			Dialogic.clear()
			reset()
		else:
			scene_manager.reset_levels()
			scene_manager.update_shutdown_count()
			Dialogic.clear()
			reset()
			state_machine = "booting"
			_animated_sprite.play("booting")
			print_debug(state_machine)
			$AnimationPlayer.play("wakeup")
			
	elif anim_name =="wakeup":
		print_debug("wakeup anim done")
		state_machine = "moving"

func on_shutdown():
	get_node("AnimationPlayer").play("shutdown");
	state_machine = "shutting"
	
