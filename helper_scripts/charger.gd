extends Area2D

@onready var sprite = $AnimatedSprite2D
@onready var light = $PointLight2D
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if scene_manager.power.charging:
		sprite.animation = "charging"
		if light.energy <1:
			light.energy += 0.05
	else:
		sprite.animation = "default"
		if light.energy >0:
			light.energy -= 0.05
	pass


func _on_body_entered(body: Node2D) -> void:
	print_debug(str(body," entered"))
	if body is Player:
		print("charging")
		scene_manager.power.charging = true;
	pass # Replace with function body.


func _on_body_exited(body: Node2D) -> void:
	if body is Player:
		scene_manager.power.charging = false;
	pass # Replace with function body.
