extends Node2D

export (PackedScene) var import_Mob

onready var player = $YSort/Player
var mob_spawn_timer

var intro_played = false

func _ready():
#	$YSort/Player/Camera2D.position.x = 1000
	mob_spawn_timer = Timer.new()
	mob_spawn_timer.set_wait_time(rand_range(1, 3))
	
#	var master_sound = AudioServer.get_bus_index("Master")
#	AudioServer.set_bus_mute(master_sound, true)
	pass # Replace with function body.

func _process(_delta):
	if Input.is_action_just_pressed("spawn_mob"):
		spawn_mob(60)
		spawn_mob(-90)
	if Input.is_action_just_pressed("restart_game"):
		get_tree().change_scene("res://Game.tscn")
	if Input.is_action_just_pressed("quit_game"):
		get_tree().quit()
	if Input.is_action_just_pressed("toggle_fullscreen"):
		OS.window_fullscreen = !OS.window_fullscreen
	if Input.is_action_just_pressed("toggle_collision_hints"):
		get_tree().debug_collisions_hint = not get_tree().debug_collisions_hint
		
		
	if fmod(player.global_position.x, 200.0) < 0.3:
		spawn_mob(300)
		
	$ParallaxBackground/sky/sky.modulate = Color(player.global_position.x/500, 1, 1)
#	$ParallaxBackground/ground/ground.modulate = Color(player.global_position.x/500, player.global_position.x/2000, player.global_position.x/2000)
#	$ParallaxBackground/trees_far/trees.modulate = Color(player.global_position.x/500, player.global_position.x/2000, player.global_position.x/2000)
func _physics_process(_delta):
#	if intro_played == false:
#		$YSort/Player/Camera2D.position.x -= 2
#	if $YSort/Player/Camera2D.position.x == $YSort/Player.global_position.x:
#		$YSort/Player/Camera2D.position = $YSort/Player.global_position
#		intro_played = true
	pass


func spawn_mob(var position_relative_to_player):
	var mob = import_Mob.instance()
	mob.connect("player_hit", self, "_on_player_hit")
#	$YSort/Player.connect("stomp_hit", mob, "_on_stomp_hit")
	$YSort.add_child(mob)

#	mob.position = player.global_position+Vector2(180+abs(randf()*40), 20-abs(randf()*40))
	mob.position = player.global_position+Vector2(position_relative_to_player+abs(randf()*40), 20-abs(randf()*40))
#	mob.position = player.global_position+Vector2(-40+abs(randf()*40), 20-abs(randf()*40))
	mob.speed = rand_range(2, 4)


func _on_StompBoxHit_area_entered(_area):
	pass # Replace with function body.
