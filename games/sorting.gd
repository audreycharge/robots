class_name Sorting extends TaskScene
var box;
var array;
var count = [0,0,0,0]
var complete = false;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super()
	box = $box/Area2D
	array = []
	count = [0,0,0,0]
	scene_manager.temp.shutdown.connect(on_shutdown)
	scene_manager.power.shutdown.connect(on_shutdown)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	array = box.get_overlapping_areas().map(get_anim)
	count = [0,0,0,0]
	#print(array)
	for i in array:
		if (i != null):
			count[i-1] +=1;
	#print(count)
	$Panel/HBoxContainer/VBoxContainer/hexnut/Label.text = str(count[0],"/10")
	$Panel/HBoxContainer/VBoxContainer2/washer/Label.text = str(count[1],"/10")
	$Panel/HBoxContainer/VBoxContainer2/can/Label.text = str(count[2],"/10")
	$Panel/HBoxContainer/VBoxContainer/nail/Label.text = str(count[3],"/10")
	
	complete = true;
	for i in count:
		if i < 10:
			complete = false;
			continue;
	scene_manager.sort_complete = complete;
	
func get_anim(nut):
	if nut.get_parent() is Nut:
		var str = nut.get_parent().get_node("Sprite2D").animation
		#print(str.to_int())
		return str.to_int()

func on_shutdown():
#	animate some stuff to initiate shutdown
#change scene to sorting room
	pass
