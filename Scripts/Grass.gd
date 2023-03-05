extends Area2D
var sway_timer : float = 0
var sway_time : float = 0.3



var original_sprite_colors = []
# Called when the node enters the scene tree for the first time.
func _ready():
	for i in range(8):
		var c = $Sprite2D.material.get_shader_parameter("C" + str(i+1))
		if c != null:
			original_sprite_colors.append(c)
		else:
			original_sprite_colors.append(Color.BLACK)
			
	$Sprite2D.add_to_group("has_outline")
	$Sprite2D.add_to_group("has_palette_swapper")
	$CollisionShape2D.add_to_group("is_collider")
	
		
	$Sprite2D.frame = randi_range(0, 1)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	sway_timer += delta
	if $Sprite2D.get_material().get_shader_parameter("enableSway"):
		if sway_timer > sway_time:
			sway_timer = 0
			$Sprite2D.get_material().set_shader_parameter("enableSway", false)
#	pass


func _on_body_entered(body):
	sway_timer = 0
#	if body.is_in_group("has_movement") and body.velocity.length() > 0:
	if body.is_in_group("has_movement") and body.current_speed > 0:
		$Sprite2D.get_material().set_shader_parameter("enableSway", true)
		body.is_in_grass = true
		
	
		
	pass # Replace with function body.


func _on_body_exited(body):
	if body.is_in_group("has_movement"):
		body.is_in_grass = false
#	sway_timer = 0
#	if body.is_in_group("has_movement"):
#		$Sprite2D.get_material().set_shader_parameter("enableSway", false)
	pass # Replace with function body.
