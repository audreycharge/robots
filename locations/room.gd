class_name ActiveRoom extends Area2D

@onready var room;
@export var map: Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	room = get_parent();
	room.visible = false
	print(room)
	pass # Replace with function body.


func _on_body_entered(body: Node2D) -> void:
	#print(body)
	for r in map.get_children():
		if (r.visible):
			r.visible = false
	room.visible = true
	pass # Replace with function body.
