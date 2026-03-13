class_name Basebot extends CharacterBody2D

@export var bot_name :String 
@onready var sprite = $AnimatedSprite2D
var location;


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	sprite.animation = bot_name
	location = get_parent().name
	print_debug(str(bot_name, " is in ", location))
	Dialogic.signal_event.connect(_on_dialogic_signal)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_dialogic_signal(argument:String):
	pass
