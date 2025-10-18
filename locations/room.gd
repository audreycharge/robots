class_name ActiveRoom extends Area2D

@onready var room;
@export var map: Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	room = get_parent();
	room.visible = false
	pass # Replace with function body.


func _on_body_entered(body: Node2D) -> void:
	#print(body)
	if body is Player:
		for r in map.get_children():
			if (r.visible):
				r.visible = false
		room.visible = true
		#print(str("test",room, body))
	pass # Replace with function body.
