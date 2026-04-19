extends Node

var collection = []
@export var nut:PackedScene
@export var scrap:PackedScene
@onready var magnet: CharacterBody2D = $"../magnet"

var time = 0;
const PERIOD = 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
		#var new_nut = nut.instantiate()
#
		#var x = randf_range(400, 1920 - 400)
		#new_nut.position = Vector2(x,y)
		#new_nut.visible = true
		#add_child(new_nut)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	time += delta;
	
	if time > PERIOD:
		var new_nut = nut.instantiate()
		var new_scrap = scrap.instantiate()
		new_scrap.position = Vector2(2200, randf_range(30, 540))
		new_nut.position.x = 2000
		new_nut.position.y = randf_range(30, 540)
		add_child(new_nut)
		add_child(new_scrap)
		time = 0;
	
	
	
	
	var test = magnet.get_child(2).get_overlapping_areas()
	#print(test)
	
	pass
