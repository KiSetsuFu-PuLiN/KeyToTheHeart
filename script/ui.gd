extends ColorRect

func _on_UIButton_pressed():
	# UI按键按下，唤出菜单
	self.set_visible(true)
	return
func _on_Resume_pressed():
	# 恢复游戏
	self.set_visible(false)
	return
# 存取计数器
export var save_load_count:int = 0
func _on_Load_pressed():
	# 加载游戏
	GameControl.load_game()
	return
func _on_Save_pressed():
	if not $"../Puzzle".finished:
		self.save_load_count += 1
		self.set_visible(false)
		GameControl.save_game()
	return
func _on_SaveQuit_pressed():
	# 保存并退出游戏
	_on_Save_pressed()
	get_tree().quit(0)
	return
func _on_Settings_pressed():
	$Settings.set_visible(true)
	return
func _on_About_pressed():
	$About.set_visible(true)
	return
func _notification(what):
	# 当用户尝试关闭时
	if what==NOTIFICATION_WM_QUIT_REQUEST or what==NOTIFICATION_WM_GO_BACK_REQUEST:
		print_debug("尝试关闭")
		# 检查是否有覆盖于UI之上的任务进行中
		var over_write:bool = false
		over_write = over_write or $"../Dialog".is_visible()
		over_write = over_write or self.is_visible()
		for child_node in $"../ScreenEffect".get_children():
			over_write = over_write or child_node.is_visible()
		# 若没有，唤起菜单
		if not over_write:
			_on_UIButton_pressed()

