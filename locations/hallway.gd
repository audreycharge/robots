extends BaseScene

@onready var trak = $Trak_broken
@onready var anim_player = $AnimationPlayer
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#print_debug("room2")
	super()
	if scene_manager.trak_break:
		init_hall_2()
		#print_debug("trak broke")
	Dialogic.signal_event.connect(on_ended)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func init_hall_2():
	trak.visible = true;
	#trak.get_node("AnimatedSprite2D").play("Trak")
	trak.bot_name = "Trak"
	trak.name = "Trak"
	trak.talk = true;
	$group_a.visible = false
	
func on_ended(arg: String):
	if arg == "final":
		scene_manager.go_to_ui(self, "ending");
	elif arg == "beam leaves":
		print_debug("leave")
		anim_player.play("beam_leaves")
	elif arg == "trak_restore":
		trak.sprite.animation = "Trak"
		
