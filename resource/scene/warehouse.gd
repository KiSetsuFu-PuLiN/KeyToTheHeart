extends Scene

func init()->void:
	if $"..".eli_get_free_on_warehouse:
		$CoffeeBean.visible = true
	else:
		start_event("warehouse/_init")
		$"..".eli_get_free_on_warehouse = true
		AudioControl.play_bgm("Unease/Ólafur Arnalds - Endalaus II")
	return


func _on_ToPedestrianStreet_pressed():
	change_scene("pedestrian_street")
	return


func _on_CoffeeBean_pressed():
	if $"..".eli_get_coffee_bean:
		pass
	else:
		start_dialog_event("warehouse/find_coffee_bean")
		add_item("咖啡豆","coffee_bean.png")
		$"..".eli_get_coffee_bean = true
	return
