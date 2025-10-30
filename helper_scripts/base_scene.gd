class_name BaseScene extends Node

@onready var player: Player = %Player
@onready var entrance_markers: Node2D = $EntranceMarkers
# Called when the node enters the scene tree for the first time.
func _ready():
	if scene_manager.player:
		if player:
			player.queue_free()
			
		player = scene_manager.player
		add_child(player)
	
	position_player()
		
func position_player() -> void:
	var last_scene = scene_manager.last_scene_name
	#print("come back")
	if last_scene.is_empty():
		last_scene = "any"
	for entrance in entrance_markers.get_children():
		#print_debug(entrance.name)
		if entrance is Marker2D and entrance.name == last_scene:
			print_debug(str("i'm coming from ",entrance.name))
			print_debug(entrance.global_position)
			
			player.global_position = entrance.global_position 
			
	
