extends Node2D

@onready var player = get_node("Player")
@onready var current_level = $TestLevel2
@onready var camera = $Camera2D
var next_level

var cullable_nodes : Array
var do_after_a_while = 5


func _ready():
#	print_tree_pretty()

	current_level.connect("change_level", _handle_change_level)
	$PostProcessing.visible = true

	Global.player = player
	self.remove_child(player)
	current_level.add_child(Global.player)
	Global.player.set_owner(current_level)
	Global.player.position = current_level.player_spawn_position
	

#	$GUILayer/GUI/Debug.set_daylight_color(Color(109, 142, 193))
	pass # Replace with function body.

func _process(_delta):	
	if Input.is_action_just_pressed("toggle_debug_gui"):
		$GUILayer/GUI/Debug.visible = !$GUILayer/GUI/Debug.visible
	
	if Input.is_action_pressed("show_debug_gui"):
		$GUILayer.visible = true
	else:
		$GUILayer.visible = false
		


		
	if Input.is_action_just_pressed("key_zoom_in"):
		camera.zoom += Vector2(1.0, 1.0)
	if Input.is_action_just_pressed("key_zoom_out"):
		camera.zoom -= Vector2(1.0, 1.0)
	if Input.is_action_just_pressed("toggle_fullscreen"):
		if DisplayServer.window_get_mode() != DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)
		else:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	if Input.is_action_just_pressed("exit_program"):
		get_tree().quit()

#	cullable_nodes = get_tree().get_nodes_in_group("is_cullable")
##	print(cullable_nodes.size())
#	for each in cullable_nodes:
#		if each != null:
#			if each.global_position.distance_to($Camera2D.global_position) > 700:
##				each.visible = false
#				each.set_process(false)
#			else:
##				each.visible = true
#				each.set_process(true)


func _handle_change_level(signaling_node, next_level_name):
	print("in _handle_change_level:")
	print("	signaling node: " + signaling_node.name)
	print("	Next level string: " + next_level_name)

	match next_level_name:
		"TestLevel1":
			next_level = load("res://Assets/Levels/test_level_1.tscn").instantiate()
		"TestLevel2":
			next_level = load("res://Assets/Levels/test_level_2.tscn").instantiate()
		"TestLevel3":
			next_level = load("res://Assets/Levels/test_level_3.tscn").instantiate()
	add_child(next_level)
	move_child(next_level, 0)
	
	#Move player
	var player_handle
	if self.has_node("Player"):
		player_handle = player
		next_level.player = player_handle
		self.remove_child(player)
		next_level.add_child(next_level.player)
		next_level.player.set_owner(next_level)
		next_level.player.position = next_level.player_spawn_position
	elif signaling_node.has_node("Player"):
		player_handle = signaling_node.player
		next_level.player = player_handle
		signaling_node.remove_child(player)
		next_level.add_child(next_level.player)
		next_level.player.set_owner(next_level)
		next_level.player.position = next_level.player_spawn_position
		
	#Free current level
	current_level.queue_free()
	current_level = next_level
	current_level.connect("change_level", _handle_change_level)




func _on_color_picker_color_changed(color):
	player.color_on_hand = color
	Global.debug_color = color
	pass # Replace with function body.

func _on_h_slider_1_value_changed(value):
	$PostProcessing/QuantizeColors.get_material().set_shader_parameter("gamma", value)
	pass # Replace with function body.
