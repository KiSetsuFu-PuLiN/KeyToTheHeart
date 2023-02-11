extends Scene

func init()->void:
	GameControl.start_cg_immediately("Black")
	start_dialog_event("room_of_eli/dialog_in_darkness")
	yield(GameControl,"dialog_finished")
	$Diary.visible = true
	$White.visible = true
	$Window.visible = true
	return


func _on_Window_pressed():
	if $"..".eli_escape_from_room():
		change_scene("road")
	else:
		start_dialog_event("room_of_eli/window_locked")
	return
func _on_White_pressed():
	if not $"..".white_get_known_by_eli:
		$"..".white_get_known_by_eli = true
		start_dialog_event("room_of_eli/console_from_white")
	return
func _on_Diary_pressed():
	if not $"..".diary_readed:
		$"..".diary_readed = true
		start_dialog_event("room_of_eli/the_diary")
	return
