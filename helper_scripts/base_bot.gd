class_name Basebot extends CharacterBody2D

@export var bot_name :String 
@onready var sprite = $AnimatedSprite2D
var location;
@export var talk: bool = false
var changed = false;


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if bot_name != "":
		sprite.animation = bot_name
	else:
		sprite.animation = "Siren"
	location = get_parent().name
	#print_debug(str(bot_name, " is in ", location))
	Dialogic.signal_event.connect(_on_dialogic_signal)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if bot_name == "Trak_broke" and !changed:
		changed = true
		sprite.animation = bot_name
	pass

func _on_dialogic_signal(argument:String):
	pass
