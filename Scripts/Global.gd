extends Node

var print_timer : float = 0
var print_timed_once : bool = false

var debug_color : Color = Color.WHITE
var debug_color2 : Color = Color.WHITE
var player

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):

	print_timer += delta
	pass

func print_timed(to_print, delay):
	if print_timer > delay:
		print_timer = 0.0
		print(to_print)

		
		
