extends ColorRect

func _on_SaveExit_pressed():
	set_visible(false)
	$"..".set_visible(false)
	GameControl.save_game()
	$"..".set_visible(true)
	return

func _notification(what):
	# 当用户尝试关闭时
	match what:
		# 返回菜单
		NOTIFICATION_WM_QUIT_REQUEST:
			self.set_visible(false)
		# 返回菜单
		NOTIFICATION_WM_GO_BACK_REQUEST:
			self.set_visible(false)
