extends Control

var temperature
var power
var parent
@onready var network_button = $HBoxContainer/network
var scene
@onready var exitButton = $Button
@onready var glitch_timer = $Timer

signal glitch_done

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	parent = get_parent()
	print_debug(parent)
	scene_manager.temp.shutdown.connect(on_shutdown)
	scene_manager.power.shutdown.connect(on_shutdown)
	if parent is Camera2D:
		exitButton.text = "settings"
		scene = parent.get_parent().get_parent()
		print_debug(scene)
	else:
		exitButton.text = "Take a Break"
	network_button.button_down.connect(on_button_down)
	power = scene_manager.power
	temperature = scene_manager.temp
	power.depleted.connect(on_low_battery)
	temperature.overheating.connect(on_overheat)
	temperature.cooled.connect(on_cooled)
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#var power_amount = power
	$Panel/PowerProgress.value = power.power
	$Panel/Temperature.text = str("Temperature: ", temperature.temp)
	#if power.charging:
		#$PowerProgress.add_theme_stylebox_override()
	

func on_button_down() -> void:
	print("network")

func on_low_battery():
	print_debug("Low Battrey")
	#$AnimationPlayer.play("overheating")
	
func on_overheat():
	print_debug("overheating")
	$AnimationPlayer.play("overheating")

func on_cooled():
	print_debug("cooled")
	$AnimationPlayer.stop()
	$Overheating.visible = false;
	
func reset():
	$AnimationPlayer.stop()
	$Overheating.visible = false;
	


func _on_button_button_down() -> void:
	if parent is Camera2D:
		$pause.visible = true;
		parent.get_parent().state_machine = "paused"
	else:
		$stop_sort.visible = true;
		if !get_parent().complete:
			$stop_sort/stop_sort/Label.text = "Stop sorting? You haven't finished your quota."
		else:
			$stop_sort/stop_sort/Label.text = "Stop sorting? You could do more."


func _on_yes_button_down() -> void:
	scene_manager.return_to_scene(parent, "sorting_room")
	if get_parent().complete:
		scene_manager.shift +=1;


func _on_no_button_down() -> void:
	$stop_sort.visible = false;


func _on_restart_button_down() -> void:
	
	pass # Replace with function body.


func _on_resume_button_down() -> void:
	$pause.visible = false;
	parent.get_parent().state_machine = "moving"
	pass # Replace with function body.


func _on_exit_button_down() -> void:
	scene = parent.get_parent().get_parent()
	print_debug(scene)
	$pause.visible = false
	scene_manager.go_to_ui(scene, "main_menu");
	#get_tree().call_deferred('change_scene_to_file',"res://UI/main_menu.tscn" )
	scene_manager.reset_levels()
	pass # Replace with function body.
	
func on_shutdown():
	$glitch.visible = true;
	glitch_timer.start()
	#print_debug("shutting down")


func _on_timer_timeout() -> void:
	$glitch.visible = false;
	glitch_done.emit()
	if parent is not Camera2D: #if you are currently sorting job
		scene_manager.reset_levels()
		scene_manager.player.reset()
		scene_manager.return_to_scene(parent, "sorting_room")
		scene_manager.you_break = true;
