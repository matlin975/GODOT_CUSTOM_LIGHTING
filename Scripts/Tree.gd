extends StaticBody2D
var original_sprite_colors = []

# Called when the node enters the scene tree for the first time.
func _ready():

	$Sprite2D.add_to_group("has_outline")
	$Sprite2D.add_to_group("has_palette_swapper")
	$CollisionShape2D.add_to_group("is_collider")
	
	var C2 = $Sprite2D.material.get_shader_parameter("C2")
	var C3 = $Sprite2D.material.get_shader_parameter("C3")

	C2 -= Color(randf_range(0, 0.05), randf_range(0, 0.05), randf_range(0, 0.05), 0)
	if randf() > 0.5:
		C3 -= Color(randf_range(0, 0.05), randf_range(0, 0.05), randf_range(0, 0.05), 0)
	else:
		C3 -= Color(randf_range(0, 0.05), randf_range(0, 0.05), randf_range(0, 0.05), 0)

	$Sprite2D.material.set_shader_parameter("C2", C2)
	$Sprite2D.material.set_shader_parameter("C3", C3)
	
	for i in range(8):
		var c = $Sprite2D.material.get_shader_parameter("C" + str(i+1))
		if c != null:
			original_sprite_colors.append(c)
		else:
			original_sprite_colors.append(Color.BLACK)



func _process(_delta):
	pass

func _on_timer_timeout():
	pass

func show():
	visible = true
func hide():
	visible = false
