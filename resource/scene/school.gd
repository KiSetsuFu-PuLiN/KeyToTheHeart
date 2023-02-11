extends Scene

func init()->void:
	if $"..".eli_is_going_to_find_black:
		pass
	else:
		start_event("school/_init")
		AudioControl.play_bgm("Unease/Soaring")
	return
	

func _on_ToRoad_pressed():
	change_scene("road")
