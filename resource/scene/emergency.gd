extends Scene

func init()->void:
	start_dialog_event("emergency/dialog_of_doctor")
	return

func _on_ToDoor_pressed():
	if $"..".finished:
		pass
	else:
		start_event("emergency/_eli_will")
		yield(GameControl,"screen_effect_finished")
		assert(not GameControl.connect("dialog_finished",self,"to_the_About"),"信号连接失败")
	return

func to_the_About()->void:
	GameControl.disconnect("dialog_finished",self,"to_the_About")
	remove_item("八音盒")
	add_item("八音盒","octavebox_crystalball_eli.png")
	$"/root/Main/UI".visible = true
	$"/root/Main/UI/About".visible = true
	start_dialog_event("emergency/meta")
	GameControl.net_work()
	yield(GameControl,"dialog_finished")
	GameControl.remove_save()
	$"..".finished = true
	change_background("emergency_leave")
	return
