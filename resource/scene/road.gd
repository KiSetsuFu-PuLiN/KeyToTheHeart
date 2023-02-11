extends Scene

func init()->void:
	$ToForest.visible = false
	$ToPark.visible = false
	$ToSchool.visible = false
	
	if $'..'.school_avalible():
		$ToSchool.visible = true
	if $"..".black_disappear:
		$ToPark.visible = true
	
	if $"..".eli_get_free_on_road:
		$ToForest.visible = true
	elif $"..".eli_escape_from_room():
		# 刚从窗户爬出来
		$ToForest.visible = true
		start_dialog_event("road/escape_from_room_of_eli")
		$"..".eli_get_free_on_road = true
		AudioControl.play_bgm("Relax/有些答案不必等待")
	else:
		# 刚来到这个场景
		start_event("road/_init")
	return



func _on_ToForest_pressed():
	change_scene("forest")
	return
func _on_ToSchool_pressed():
	if $"..".eli_is_going_to_find_black:
		change_scene("school")
	elif $"..".black_disappear:
		start_dialog_event("scilence_of_white")
	elif $"..".school_avalible():
		change_scene("school")
	else:
		pass
	return
func _on_ToPark_pressed():
	if $"..".eli_is_going_to_find_black:
		change_scene("park")
	elif $"..".black_disappear:
		start_dialog_event("scilence_of_white")
	else:
		pass
	return
