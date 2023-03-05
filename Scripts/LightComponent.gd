
extends Node

@export var sprite : Sprite2D
@export var sprite_offset : Vector2
@export var do_shadows : bool = true
@export var outline_strength_scaler:float = 1
@export var intensity_curve : Curve
@export var intensity_curve2 : Curve2D

var global_position :Vector2
#var sprite
var sprite_material
var sprite_height

var shadow_array : Array[Sprite2D]

var emissive_nodes_array
var previous_emissive_node
var closest_emmisive_node = null
var color_blend : Color
var shadow_threshold_distance = 1000
var light_threshold_distance = 1000
var blended_color = Color(0, 0, 0, 0)

var debug_mode = false
var time = 0.0
var do_once = false

var light_vector = Vector2.ZERO
var default_light_intensity = 0.1

var light_intensity : float
var light_color : Color

func _ready():
	add_to_group("is_light_component")
	intensity_curve = load("res://Assets/Components/intensity_curve.tres")
#	print(sprite)
	if sprite == null:
		sprite = get_node("../Sprite2D")
	sprite_offset = sprite.offset
	sprite_material = sprite.get_material()
	sprite_height = sprite.texture.get_height()
	pass

func _process(_delta):
	global_position = get_parent().global_position
	if get_parent().visible == true:
		do_lights_and_shadows()
	
func do_lights_and_shadows():
	#Hide shadows
	for node in shadow_array:
		if node == null:
			shadow_array.erase(null)
		elif node.name.begins_with("shadow_"):
			node.visible = false

	#Get all emissive nodes
	emissive_nodes_array = get_tree().get_nodes_in_group("is_emissive")
	
	#Do Shadows
	if do_shadows == true:
		for emissive_node in emissive_nodes_array:
			if emissive_node.visible and (emissive_node.global_position - sprite.global_position).length() < shadow_threshold_distance:
				if shadow_array.find(emissive_node) == -1:
					shadow_array.append(emissive_node)
					emissive_node.connect("destructor", _on_emissive_node_destructor)

					var new_shadow = sprite.duplicate()
					new_shadow.material = null
					new_shadow.modulate = Color.BLACK
#					new_shadow.centered = sprite.centered
#					if sprite_offset != Vector2.ZERO:
					new_shadow.position = Vector2.ZERO
					new_shadow.offset = Vector2(0, -sprite_height/2)
#					new_shadow.z_index = -2
					add_sibling(new_shadow)

					new_shadow.name = "shadow_" + new_shadow.name
					shadow_array.insert(shadow_array.find(emissive_node)+1, new_shadow)
				else:
					var shadow = shadow_array[shadow_array.find(emissive_node)+1]
					shadow.visible = true
					light_vector = (emissive_node.global_position - shadow.global_position).normalized()
					shadow.skew = light_vector.angle()-PI/2

#					shadow.modulate.a = 0.75-shadow.global_position.distance_to(emissive_node.global_position)*0.005
					var r = emissive_node.light_color.r
					var g = emissive_node.light_color.g
					var b = emissive_node.light_color.b
										
					var color_sphere_radius = sqrt(pow(r, 2)+pow(g, 2)+pow(b, 2)/3)
					var radius_clamped = clampf(color_sphere_radius, 0, 0.8)
					shadow.modulate.a = radius_clamped - shadow.global_position.distance_to(emissive_node.global_position)*0.005

					shadow.scale.y = shadow.global_position.distance_to(emissive_node.global_position)*0.025
					shadow.frame = sprite.frame
					shadow.flip_h = sprite.flip_h


	#Do Lights
	var no_nodes = 0
	var diff_vect = Vector2.ZERO
	for emissive_node in emissive_nodes_array:
		
#		Global.print_timed(diff_vect, 0.2)
		var parent_pos = get_parent().global_position
		var dist_to_node = parent_pos.distance_to(emissive_node.global_position)
		if emissive_node.visible and dist_to_node < light_threshold_distance:	
			no_nodes+=1
			diff_vect = parent_pos - emissive_node.global_position
#			blended_color += emissive_node.light_color * 2000/( pow(sprite.global_position.distance_to(emissive_node.global_position), 2) )
#			blended_color += emissive_node.light_color / (parent_pos.distance_to(emissive_node.global_position)*0.02)
			var light_curve_y = intensity_curve.sample(1-parent_pos.distance_to(emissive_node.global_position)/736)
			light_curve_y = snappedf(light_curve_y, 0.01)
			blended_color = emissive_node.light_color * light_curve_y
#			Global.print_timed(parent_pos.distance_to(emissive_node.global_position)/736, 0.5)
			Global.print_timed(light_curve_y, 0.5)
			
			
	blended_color /= no_nodes
	blended_color = blended_color.clamp(Color(0, 0, 0, 0), Color(1, 1, 1, 1))
	var intensity_vector = Vector4(blended_color.r, blended_color.g, blended_color.b, blended_color.a)
	light_intensity = intensity_vector.length()
	
	if diff_vect.y < 0:
		#light is in front of object
		sprite_material.set_shader_parameter("reverse_depth", false)
		sprite_material.set_shader_parameter("light_color", blended_color)
		sprite_material.set_shader_parameter("light_intensity", intensity_vector.length())
		sprite_material.set_shader_parameter("outline_color", blended_color*intensity_vector.length()*0.0)	
	else:
		#light is behind object
		sprite_material.set_shader_parameter("reverse_depth", true)
		sprite_material.set_shader_parameter("light_color", blended_color*0.3)
		sprite_material.set_shader_parameter("light_intensity", intensity_vector.length())
#		sprite_material.set_shader_parameter( "outline_color", blended_color * intensity_vector.length() * outline_strength_scaler )
	
	#reset
	blended_color = Color(0, 0, 0, 0)
	if no_nodes == 0:
		sprite_material.set_shader_parameter("light_intensity", 0)
		sprite_material.set_shader_parameter("light_color", Color.BLACK)
		sprite_material.set_shader_parameter("outline_color", Color.BLACK)

func _on_emissive_node_destructor(_node):
	for each in shadow_array:
		if each != null:
			if each.name.begins_with("shadow_"):
				shadow_array.erase(each)
				each.queue_free()

	shadow_array.clear()
	emissive_nodes_array.clear()
	emissive_nodes_array = get_tree().get_nodes_in_group("is_emissive")

func _on_timer_timeout():
#	print(emissive_nodes_array)
#	print(shadow_array)
	pass # Replace with function body.
