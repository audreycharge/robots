class_name Scraps extends CharacterBody2D


@onready var sprite = $Sprite2D

func _ready() -> void:
	var img = randi() % 6
	sprite.animation = str(img)
	velocity.y = 0;
	velocity.x = -300
	pass # Replace with function body.

func _physics_process(delta: float) -> void:
	velocity = Vector2(-300, 0)

	move_and_slide()
