extends Scene

func init()->void:
	if $"..".black_disappear:
		$White.texture_normal = preload("res://resource/image/icon/don't_leave_me.png")
	if $"..".eli_is_going_to_school:
		pass
	elif $"..".eli_wakeup_from_rooftop:
		start_dialog_event("home_of_treehole/after_wake_up")
		$"..".eli_is_going_to_school = true
	elif $"..".home_of_treehole_get_known_by_eli:
		pass
	else:
		start_dialog_event("home_of_treehole/enter_the_home_of_treehole")
		$"..".home_of_treehole_get_known_by_eli = true
	return


func _on_ToForest_pressed():
	if $"..".eli_is_going_to_find_black:
		change_scene("forest")
	elif $"..".black_disappear:
		start_dialog_event("scilence_of_white")
	else:
		change_scene("forest")
	return


func _on_White_pressed():
	if $"..".eli_is_going_to_find_black:
		pass
	elif $"..".black_disappear:
		start_event("home_of_treehole/_white_pressed_after_black_disappear")
		yield(GameControl,"screen_effect_finished")
		yield(GameControl,"dialog_finished")
		add_item("白兔玩偶","doll.png")
		remove_item("水晶球")
		add_item("水晶球","crystalball_eli.png")
		AudioControl.play_bgm("Regret/Ficus")
		$"..".eli_is_going_to_find_black = true
	elif $"..".eli_wakeup_from_rooftop:
		pass
	else:
		start_event("home_of_treehole/_white_pressed_init")
	return

	
