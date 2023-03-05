extends Sprite2D

@export var light_color : Color :
	get:
		return light_color
	set(value):
		light_color = value
		get_material().set_shader_parameter("light_color", light_color)
		get_material().set_shader_parameter("C2", light_color)

@onready var sprite_shader = preload("res://Assets/Shaders/palette_swapper.gdshader")
var sprite_shader_instance

signal destructor

func _ready():
	add_to_group("is_emissive")
	
	material = ShaderMaterial.new()
	material.shader = sprite_shader
	
	get_material().set_shader_parameter("light_color", light_color)
	get_material().set_shader_parameter("light_intensity", 1.0)
	get_material().set_shader_parameter("C2", light_color)
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_tree_exited():
	emit_signal("destructor", self)
