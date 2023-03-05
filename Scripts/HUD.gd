extends CanvasLayer
#
onready var player = get_node("../YSort/Player")
onready var player_mouth = get_node("../YSort/Player/Mouth")
var player_pos 
#
#var hp_tween = null
#var en_tween = null
#
#var hp_old_size = 0
#var hp_size = 0
#
#var en_old_size = 0
#var en_size = 0
#
#var last_combat_state = false
#
#
## Called when the node enters the scene tree for the first time.
func _ready():
#	player_pos = player.get_canvas_transform().origin + player.position
	player_pos = player.get_global_transform_with_canvas().get_origin()
#	$Control/TalkBubble.text = player_mouth.buffer
	$Control.rect_position = player_pos
#	$Control/TalkBubble.margin_left = player_pos.x
#	$Control/TalkBubble.margin_right = player_pos.x + 100
#	$Control/TalkBubble.margin_top = player_pos.y
#	$Control/TalkBubble.margin_bottom = player_pos.y + 100
	
#	hp_size = player.hitpoints
#	en_size = player.energy
#	en_old_size = player.energy
#	$Panel/Bars/HpBar.rect_size.x = player.hitpoints
#	$Panel/Bars/EnBar.rect_size.x = player.energy
#
#	$Panel.modulate = Color(1, 1, 1, 0.4)
##	$HpTween.interpolate_property($Panel/HpBar, "rect_size:x", hp_old_size, hp_size, 0.2, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
##	$EnTween.interpolate_property($Panel/EnBar, "rect_size:x", en_old_size, en_size, 0.2, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
##	pass # Replace with function body.
#
#
## Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
#	var temp = player_mouth.buffer
#	print(player_mouth.i)
#	$Control/TalkBubble.text = temp[1]
	$Control/TalkBubble.margin_left = player.global_position.x
	$Control/TalkBubble.margin_right = player.global_position.x + 200
	$Control/TalkBubble.margin_top = player.global_position.y
	$Control/TalkBubble.margin_bottom = player.global_position.y + 200
	
#	player_pos = player.get_global_transform_with_canvas().get_origin()
	$Control/TalkBubble.text = player_mouth.buffer.substr(0, player_mouth.i)
#	$Control.rect_position = player_pos
#
##	$Panel/HpBar.rect_size.x = player.hitpoints
##	$Panel/EnBar.rect_size.x = player.energy
#
##	print(player.is_in_combat)
#	en_size = player.energy
#	hp_size = player.hitpoints
#
#	if player.is_in_combat == true and $OpacityTween.is_active() == false:
##		$Panel.modulate = Color(1, 1, 1, 1)
#		if last_combat_state == false:
#			$OpacityTween.interpolate_property($Panel, "modulate", $Panel.modulate, Color(1, 1, 1, 1), 0.2,
#										   Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
#			$OpacityTween.start()
#			last_combat_state = true
#	elif player.is_in_combat == false and $OpacityTween.is_active() == false:
##		$Panel.modulate = Color(1, 1, 1, 0.2)
#		if last_combat_state == true:
#			$OpacityTween.interpolate_property($Panel, "modulate", $Panel.modulate, Color(1, 1, 1, 0.4), 1,
#										   Tween.TRANS_CUBIC, Tween.EASE_OUT, 2)
#			$OpacityTween.start()
#			last_combat_state = false
#
#	if hp_old_size > hp_size:
#		$HpTween.interpolate_property($Panel/Bars/HpBar, "rect_size:x", hp_old_size, hp_size, 1, Tween.TRANS_ELASTIC, Tween.EASE_OUT)
#		$HpTween.start()
#	elif $HpTween.is_active() == false:
#		$Panel/Bars/HpBar.rect_size.x = hp_size
#
#	if en_old_size > en_size+10:
#		if $EnTween.is_active() == false:
#			$EnTween.interpolate_property($Panel/Bars/EnBar, "rect_size:x", en_old_size, en_size, 0.1, Tween.TRANS_BACK, Tween.EASE_OUT)
#			$EnTween.start()
#	elif $EnTween.is_active() == false:
#		$Panel/Bars/EnBar.rect_size.x = en_size
#
##	if $EnTween.is_active() == false:
##		$EnTween.interpolate_property($Panel/Bars/EnBar, "rect_size:x", en_old_size, en_size, 0.3, Tween.TRANS_BACK, Tween.EASE_OUT)
##		$EnTween.start()
#
#	hp_old_size = hp_size
#	en_old_size = en_size
#
#
#
##func _on_OpacityTween_tween_all_completed():
##	if player.is_in_combat == true:
##		last_combat_state = true
##	else:
##		last_combat_state = false
##	pass # Replace with function body.
