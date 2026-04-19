extends Area2D

var magnetized = false
var load = 1;
const MAX_LOAD = 4;

signal overpowered;
signal lower;
signal magnetizedSignal;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if magnetized and !get_overlapping_bodies().is_empty():
		
		var bodies = get_overlapping_bodies()
		for i in bodies.size():
			if bodies[i].is_in_group("magnetic") and i < load:
				print_debug(str("magnets/",i))
				bodies[i].position = get_parent().get_node(str("magnets/",i)).global_position
				#print_debug(get_parent().get_node("Marker2D").position)
	pass

func reset():
	magnetized = false
	load = 1
	print_debug("magnets off")
	scene_manager.temp.get_node("heatup").stop()

func _on_body_entered(body: Node2D) -> void:
	print_debug(body)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("magnetize"):
		magnetized = !magnetized
		if magnetized:
			scene_manager.temp.get_node("heatup").start()
			scene_manager.temp.cooldown = false;
			magnetizedSignal.emit()
		else:
			scene_manager.temp.get_node("heatup").stop()
			if scene_manager.temp.sent:
				scene_manager.temp.init_cooldown()
	if event.is_action_pressed("load_up") and load < MAX_LOAD:
		load+= 1
		scene_manager.temp.get_node("heatup").wait_time = 2/load
		print_debug(load)
	elif event.is_action_pressed("load_up"):
		overpowered.emit()
	if event.is_action_pressed("load_down") and load > 1:
		load-=1
		scene_manager.temp.get_node("heatup").wait_time = 2/load
		print_debug(load)
	elif event.is_action_pressed("load_down"):
		lower.emit();
