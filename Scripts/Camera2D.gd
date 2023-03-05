extends Camera2D

#var NoiseMachine = load("res://Assets/Scripts/Noise.gd").new()

var tween
#const tween_script = preload("res://Assets/Scripts/CameraTween.gd")

var time = 0
var trauma = 0
const trauma_heavy = 0.8
const trauma_medium = 0.2
const trauma_light = 0.01

const shake_long = 2
const shake_medium = 1
const shake_short = 0.25
var shake_time = shake_medium

var zoomspeed = 0.01
var zoom_max = 0.5
var zoom_min = 0.16

func _ready():	

	zoom = Vector2(3.0, 3.0)
#	pass

func _process(_delta):
#	global_position.lerp( get_node("../Player").global_position, 0.5 )
	if Global.player != null:
#		position = Global.player.position
		position = lerp(position, Global.player.position, 0.5)
	
#	if Input.is_action_just_pressed("shake"):
#		shake(trauma_heavy, 5)

#	time += delta
#	position.x = position.x + (5 - NoiseMachine.squirrel3(time*100, 2)%10) * trauma
#	position.y = position.y + (5 - NoiseMachine.squirrel3(time*100, 3)%10) * trauma
#	rotation_degrees = rotation_degrees - (5 - NoiseMachine.squirrel3(time*100, 3)%10) * trauma/2

#func _input(event):
#	if event is InputEventMouseButton:
#		if event.is_pressed():
#			# zoom in
#			if event.button_index == BUTTON_WHEEL_UP:
#				zoom.x -= zoomspeed
#				zoom.y -= zoomspeed
#			# zoom out
#			if event.button_index == BUTTON_WHEEL_DOWN:
#				zoom.x += zoomspeed
#				zoom.y += zoomspeed
#		zoom.x = clamp(zoom.x,zoom_min, zoom_max)
#		zoom.y = clamp(zoom.y,zoom_min, zoom_max)

#func shake(var amount, var time):
##		smoothing_enabled = false
#		tween = Tween.new()
#		tween.set_script(tween_script)
#		add_child(tween)
#		tween.interpolate_property(self, "trauma", amount, 0, time, Tween.TRANS_QUAD, Tween.EASE_OUT)
#		tween.connect("tween_completed", tween, "_tween_completed")
#		tween.connect("completed", self, "_tween_completed")
#		tween.start()
#
#		var tween2 = Tween.new()
#		tween2.set_script(tween_script)
#		add_child(tween2)
#		tween2.interpolate_property(self, "rotation_degrees", rotation_degrees, 0, time, Tween.TRANS_LINEAR, Tween.EASE_IN)
#		tween2.interpolate_property(self, "position", position, Vector2(0, 0), time, Tween.TRANS_LINEAR, Tween.EASE_IN)
##		tween2.interpolate_property(self, "rotation_degrees", rotation_degrees, 0, time, Tween.TRANS_LINEAR, Tween.EASE_IN)
#		tween2.connect("tween_completed", tween2, "_tween_completed")
##		tween.connect("completed", self, "_tween_completed")
#		tween2.start()
#func _tween_completed():
#		smoothing_enabled = true

