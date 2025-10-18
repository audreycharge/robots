extends Node

var collection = []
@export var nut:PackedScene
@onready var magnet: CharacterBody2D = $"../magnet"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for n in 40:
		var new_nut = nut.instantiate()
		if n % 4 == 0:
			new_nut.find_child("nuts").play("heart")
		elif n % 3 == 1:
			new_nut.find_child("nuts").play("triangle")
		elif n % 3 == 2:
			new_nut.find_child("nuts").play("circle")
		else:
			new_nut.find_child("nuts").play("square")
		var x = randf_range(400, 1920 - 400)
		var y = randf_range(30, 540)
		new_nut.position = Vector2(x,y)
		new_nut.visible = true
		add_child(new_nut)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var test = magnet.get_child(2).get_overlapping_areas()
	#print(test)
	
	pass
