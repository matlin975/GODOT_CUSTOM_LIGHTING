extends Panel

# Timestamps of frames rendered in the last second
var times := []

var player
var fps := 0

func _ready():
	player = get_node("../../../Player")
	visible = true

func _process(_delta: float) -> void:
	var now := Time.get_ticks_msec()

	# Remove frames older than 1 second in the `times` array
	while times.size() > 0 and times[0] <= now - 1000:
		times.pop_front()
	times.append(now)
	fps = times.size()
	$Fps.text = str(fps) + " FPS"
	


	if player != null:
		$States.text = str(player.fsm.states)

	$Nodecount.text = str(get_tree().get_node_count())

func _on_h_slider_1_value_changed(value):
	$Gamma/Label.text = "Gamma: " + str(value)


func _on_toggle_collider_debug_toggled(button_pressed):
	for each in get_tree().get_nodes_in_group("is_collider"):
		each.visible = button_pressed


func _on_toggle_post_processing_toggled(button_pressed):
	$"../../../PostProcessing/QuantizeColors".visible = button_pressed


func _on_toggle_collider_debug_2_toggled(button_pressed):
	for each in get_tree().get_nodes_in_group("has_outline"):
		if each != null:
			if each.get_material() != null:
				each.get_material().set_shader_parameter("outline_enabled", button_pressed)


func _on_daytime_value_changed(value):
	for each in get_tree().get_nodes_in_group("has_palette_swapper"):
		if each != null:
			if each.get_material() != null:
				for i in range(7):
					each.get_material().set_shader_parameter("C"+str(i+1), each.get_parent().original_sprite_colors[i+1]*(Global.debug_color2*value))


func _on_color_picker_2_color_changed(color):
	Global.debug_color2 = color
	set_daylight_color(color*$Daytime.value)


func set_daylight_color(color):
	for each in get_tree().get_nodes_in_group("has_palette_swapper"):
		if each != null:
			if each.get_material() != null:
				for i in range(8):
					each.get_material().set_shader_parameter("C"+str(i+1), each.get_parent().original_sprite_colors[i]*color)
