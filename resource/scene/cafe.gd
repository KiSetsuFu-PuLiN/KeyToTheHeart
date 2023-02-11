extends Scene

func init()->void:
	if $"..".eli_get_free_on_cafe:
		pass
	else:
		GameControl.start_dialog_event("cafe/init")
		$"..".eli_get_free_on_cafe = true
	return

func _on_ToPedestrianStreet_pressed():
	change_scene("pedestrian_street")
	return


func _on_CoffeeMachine_pressed():
	if $"..".black_disappear:
		pass
	elif $"..".eli_get_coffee_bean:
		remove_item("咖啡豆")
		start_dialog_event("cafe/prepare_the_coffee")
		assert(not GameControl.connect("dialog_finished",self,"dialog_prepare_the_coffee_finished"),"信号连接失败")
	else:
		start_dialog_event("cafe/need_coffee_bean")
	return

func dialog_prepare_the_coffee_finished()->void:
	GameControl.disconnect("dialog_finished",self,"dialog_prepare_the_coffee_finished")
	change_background("cafe_real")
	start_dialog_event("cafe/illusion_of_chesh")
	assert(not GameControl.connect("dialog_finished",self,"illusion_of_chesh_finished"),"信号连接失败")
	return

func illusion_of_chesh_finished()->void:
	GameControl.disconnect("dialog_finished",self,"illusion_of_chesh_finished")
	# 爱丽许下愿望
	start_screen_effect_event("Wish")
	yield(GameControl,"screen_effect_finished")
	change_background("cafe_dream")
	add_item("水晶球","crystalball.png")
	start_dialog_event("cafe/dialog_of_white")
	$"..".black_disappear = true
	return
