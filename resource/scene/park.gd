extends Scene

func init()->void:
	$ToRoad.visible = false
	$ToPedestrianStreet.visible = false
	
	if $"..".black_disappear:
		$ToRoad.visible = true
	$ToPedestrianStreet.visible = true
	if $"..".eli_get_free_on_park:
		pass
	else:
		# 爱丽和郡然在公园的对话
		start_dialog_event("park/illusion_of_chesh")
		assert(not GameControl.connect("dialog_finished",self,"dialog_of_chesh_finished"),"信号连接失败")
		$"..".eli_get_free_on_park = true
		AudioControl.play_bgm("Relax/missing my ntpp")
	return

func dialog_of_chesh_finished()->void:
	change_background("park_dream")
	GameControl.disconnect("dialog_finished",self,"dialog_of_chesh_finished")
	start_dialog_event("park/dialog_of_black")
	return

func _on_ToPedestrianStreet_pressed():
	if $"..".eli_is_going_to_find_black:
		change_scene("pedestrian_street")
	elif $"..".black_disappear:
		start_dialog_event("scilence_of_white")
	else:
		change_scene("pedestrian_street")
	return


func _on_ToRoad_pressed():
	if $"..".black_disappear:
		change_scene("road")
	else:
		pass
