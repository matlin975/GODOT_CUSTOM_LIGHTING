extends Node2D

var time = 0.0
var speed = 1000.0
var fade_position:Vector2 = Vector2.ZERO
var fade_radius:float = 0.02

var distance_traveled = 0
var turn_around_value = 0

var draw_once_every_frame = 5

var emissive_nodes_array
var light_threshold_distance = 1000
@export var intensity_curve : Curve
var blended_color : Color = Color.BLACK

func _ready():
	turn_around_value = randi_range(200, 1000)
	speed = randf_range(0.4, 2)
	if randi_range(0, 1) == 0:
		speed *= -1
	else:
		speed *= 1
#	speed *= randi_range(-1, 1)
	$Sprite2D.frame = randi_range(0, 3)
	pass # Replace with function body.

func _process(delta):
	fade_position = Global.player.global_position
	var dist = fade_position - global_position
	dist.y = dist.y * 2.0
	var dist_len = dist.length()
	
	if dist_len > 800:
		visible = false
	else:
		visible = true


	time += delta
	if distance_traveled < turn_around_value:
		distance_traveled += 1
		global_position.x += speed*delta
	elif distance_traveled >= turn_around_value and distance_traveled < turn_around_value*2:
		distance_traveled += 1
		global_position.x -= speed*delta
	elif distance_traveled == turn_around_value*2:
#			Global.print_timed(distance_traveled, 0.2)
		distance_traveled = 0
	
	if visible == true:
		emissive_nodes_array = get_tree().get_nodes_in_group("is_emissive")
		var no_nodes = 0
		var diff_vect = Vector2.ZERO
		var light_curve_y = 0.0
		for emissive_node in emissive_nodes_array:
			var dist_to_node = global_position.distance_to(emissive_node.global_position)
			if emissive_node.visible and dist_to_node < light_threshold_distance:	
				no_nodes+=1
				diff_vect = global_position - emissive_node.global_position
				light_curve_y = intensity_curve.sample(1-global_position.distance_to(emissive_node.global_position)/736)
				light_curve_y = snappedf(light_curve_y, 0.01)
				blended_color = emissive_node.light_color * light_curve_y				
		blended_color /= no_nodes
		blended_color = blended_color.clamp(Color(0, 0, 0, 0), Color(1, 1, 1, 1))
		$Sprite2D.self_modulate = Color.WHITE * 0.1 + blended_color*2
		$Sprite2D.self_modulate.a = Vector3(blended_color.r, blended_color.g, blended_color.b).length()/8
	pass
