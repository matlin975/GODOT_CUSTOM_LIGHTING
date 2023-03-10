extends Node2D

@onready var texture:Texture2D = $Sprite2D.texture

var grass_image:Array = []

var height:int = 0
var width:int = 0

var do_once = false
var original_sprite_colors = []

func _ready():
	for i in range(8):
		original_sprite_colors.append($Sprite2D.material.get_shader_parameter("C" + str(i+1)))

	height = texture.get_height()
	width = texture.get_width()	
	var noise = texture.noise.get_image(width, height)


	for w in width:
		grass_image.append([])
		for h in height:
			if noise != null:
				if noise.get_pixel(w, h).r > 0.1:
					grass_image[w].append(1)
				else:
					grass_image[w].append(0)
			else:
				grass_image[w].append(0)

func _process(_delta):
	pass
