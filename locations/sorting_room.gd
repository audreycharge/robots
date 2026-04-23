class_name SortingRoom extends BaseScene

signal break_trak;
signal get_broken;
@onready var anim_player = $AnimationPlayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#print_debug("room2")
	super()
	#print_debug(player.global_position)
	Dialogic.signal_event.connect(_on_dialogic_signal)
	if scene_manager.sort_complete:
		Dialogic.VAR.work = false;
		scene_manager.break_talks = 0;
		scene_manager.sort_complete = false;
		print_debug("i dont need to work")
	else:
		print_debug("i need to work")
	
	
	if scene_manager.shift == 2 and !scene_manager.trak_break:
		scene_manager.trak_break = true;
		break_trak.emit()
		print_debug("break trak")
	
	if scene_manager.you_break:
		get_broken.emit()
		scene_manager.player.get_node("AnimationPlayer").play("wakeup")
		scene_manager.player.state_machine = "booting"
		print_debug("get broken idiot")
		scene_manager.change_scene(self, "homeroom")
		#Dialogic.start("sorting_room", "you_broke")
		
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_dialogic_signal(arg: String):
	if arg == "respond":
		if scene_manager.break_talks < 1:
			scene_manager.break_talks += 1
		else:
			Dialogic.VAR.work = true;
	print_debug(scene_manager.break_talks)


func _on_break_trak() -> void:
	anim_player.play("trak_broke")
	Dialogic.play("sorting_room", "trak_broke")
