extends Node2D

signal change_level
signal move_player

var player
var player_spawn_position
var move_player_once = 0

@export var light: PackedScene
var light_array : Array
var mouse_light
var dragging = false
var level_generated = false

func _ready():
	$EmissiveFire.light_color = Color.ORANGE_RED
	
	mouse_light = light.instantiate()
	mouse_light.light_color = Color(randf(), randf(), randf(), 1)
	mouse_light.visible = false
	add_child(mouse_light)
	
	move_player_once = 0
	player_spawn_position = $PlayerSpawnPoint.position

	pass # Replace with function body.

func _process(_delta):
	$EmissiveFire.light_color = Global.debug_color
	
	if level_generated == false:
		level_generated = true
		generate_grass_random()

		generate_fog_random()
		generate_trees_random()
	
	if move_player_once == 0:
		move_player_once = -1
		emit_signal("move_player", self)

var time = 0
func _physics_process(delta):
	mouse_light.global_position = get_global_mouse_position()+Vector2(0, 0)

	if Input.is_action_pressed("key_fire"):
		if dragging == true:
			$EmissiveFire.global_position = get_global_mouse_position()
	if Input.is_action_just_released("key_fire"):
		dragging = false

	if Input.is_action_just_pressed("key_fire"):
		mouse_light.light_color = Color(randf(), randf(), randf(), 1)

	if Input.is_action_just_pressed("key_block"):
		mouse_light.visible = !mouse_light.visible
#		mouse_light2.visible = !mouse_light2.visible

	for each in light_array:
		each.position.x -= 2
		time += delta
		
		if each.position.x < -500:
			light_array.erase(each)
			each.queue_free()
			

	if time > PI*2:
		time = 0

func _on_button_pressed():
	emit_signal("change_level", self, "TestLevel1")


func _on_drag_button_pressed():
	dragging = true
#	$EmissiveFire.global_position = get_global_mouse_position()
	pass # Replace with function body.

func generate_trees_random():
	for x in range(2048):
		for y in range(2048):
			if randf() > 0.99995:
				var a_tree = load("res://Assets/Environment/Tree5/tree_5.tscn").instantiate()
				add_child(a_tree)
				a_tree.position = Vector2(x, y)-Vector2(1024, 1024)
	return true

func generate_grass_random():
	for x in range(204):
		for y in range(204):
			if randf() > 0.95:
				var a_grass = load("res://Assets/Environment/Grass1/grass_1.tscn").instantiate()
				add_child(a_grass)
				a_grass.position = Vector2(x*10, y*10)-Vector2(1024, 1024)
	return true

func generate_fog_random():
	for x in range(204):
		for y in range(204):
			if randf() > 0.95:
				var thing = load("res://Assets/Environment/Fog1/fog1.tscn").instantiate()
				add_child(thing)
				thing.position = Vector2(x*10, y*10)-Vector2(1024, 1024)
	return true

func generate_one_tree():
				var a_tree = load("res://Assets/Environment/Tree5/tree_5.tscn").instantiate()
				add_child(a_tree)
				a_tree.position = Vector2(0, 0)
	
