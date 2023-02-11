extends Scene

func init()->void:
	return


func _on_ToHomeOfTreehole_pressed():
	change_scene("home_of_treehole")
	return


func _on_ToRoad_pressed():
	if $"..".eli_is_going_to_find_black:
		change_scene("road")
	elif $"..".black_disappear:
		start_dialog_event("scilence_of_white")
	else:
		change_scene("road")
