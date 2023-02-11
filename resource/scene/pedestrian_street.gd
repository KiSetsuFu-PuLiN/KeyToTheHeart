extends Scene

func init()->void:
	if $"..".eli_is_going_to_find_black:
		start_dialog_event("pedestrain_street/black_is_waiting")
		assert(not GameControl.connect("dialog_finished",self,"dialog_of_the_last_memory"),"信号连接失败")
	elif $"..".eli_get_free_on_pedestrian_street:
		AudioControl.play_bgm("Relax/Dreamin")
		$ToCafe.visible = true
		$ToPark.visible = true
		$ToWarehouse.visible = true
	else:
		# 爱丽初到步行街对话
		start_event("pedestrain_street/_init")
		$"..".eli_get_free_on_pedestrian_street = true
	return

func dialog_of_the_last_memory()->void:
	GameControl.disconnect("dialog_finished",self,"dialog_of_the_last_memory")
	change_background("pedestrain_street_christmas")
	remove_item("白兔玩偶")
	remove_item("水晶球")
	add_item("八音盒","octavebox_crystalball_eli_lightness.png")
	start_dialog_event("pedestrain_street/dialog_of_the_last_memory")
	yield(GameControl,"dialog_finished")
	remove_item("八音盒")
	add_item("八音盒","octavebox_crystalball_eli_chesh_broken_snow.png")
	$ToCafe.visible = false
	$ToPark.visible = false
	$ToWarehouse.visible = false
	change_background("pedestrain_street")
	start_dialog_event("pedestrain_street/going_to_break")
	yield(GameControl,"dialog_finished")
	change_background("blank")
	start_dialog_event("pedestrain_street/console_from_black")
	yield(GameControl,"dialog_finished")
	GameControl.start_cg_immediately("Black")
	change_scene("emergency")
	return

func _on_ToPark_pressed():
	change_scene("park")
	return
func _on_ToWarehouse_pressed():
	if $"..".eli_is_going_to_find_black:
		change_scene("warehouse")
	elif $"..".black_disappear:
		start_dialog_event("scilence_of_white")
	else:
		change_scene("warehouse")
	return
func _on_ToCafe_pressed():
	if $"..".eli_is_going_to_find_black:
		change_scene("cafe")
	elif $"..".black_disappear:
		start_dialog_event("scilence_of_white")
	else:
		change_scene("cafe")
	return
